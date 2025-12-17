-- PEARL Database Schema v0.2
-- Copy and paste this entire SQL into Supabase SQL Editor
-- Run with Cmd/Ctrl + Enter

-- ============================================
-- EXPERIMENTS TABLE (IMMUTABLE)
-- ============================================
-- Once inserted, experiments CANNOT be updated
-- This prevents hindsight bias and ensures data integrity

CREATE TABLE IF NOT EXISTS experiments (
  id BIGSERIAL PRIMARY KEY,
  schema_version TEXT NOT NULL DEFAULT '0.2',
  experiment_id TEXT NOT NULL UNIQUE,
  timestamp TIMESTAMPTZ NOT NULL,
  contributor TEXT NOT NULL,
  parent_experiment TEXT REFERENCES experiments(experiment_id),
  
  -- Task (required)
  task JSONB NOT NULL,
  
  -- Hardware fingerprint (required)
  hardware JSONB NOT NULL,
  hardware_id TEXT GENERATED ALWAYS AS (
    encode(sha256(hardware::text::bytea), 'hex')
  ) STORED,
  
  -- Environment context (required)
  environment JSONB NOT NULL,
  
  -- Data
  sensors_data JSONB,
  actions JSONB,
  
  -- Outcome (required)
  outcome JSONB NOT NULL,
  reward NUMERIC NOT NULL,
  
  -- Metadata
  notes TEXT,
  reproducibility_score NUMERIC GENERATED ALWAYS AS (
    -- Auto-calculate based on data completeness
    CASE 
      WHEN hardware->>'mcu' IS NOT NULL 
       AND hardware->>'motors' IS NOT NULL 
       AND hardware->>'power_source' IS NOT NULL
       AND environment->>'surface' IS NOT NULL
       AND environment->>'lighting' IS NOT NULL
      THEN 1.0
      ELSE 0.5
    END
  ) STORED,
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  
  -- Constraints
  CONSTRAINT valid_task CHECK (task->>'type' IS NOT NULL),
  CONSTRAINT valid_environment CHECK (
    environment->>'surface' IS NOT NULL AND
    environment->>'lighting' IS NOT NULL AND
    environment->>'load' IS NOT NULL
  ),
  CONSTRAINT valid_outcome CHECK (outcome->>'success' IS NOT NULL)
);

-- ============================================
-- ANNOTATIONS TABLE (APPEND-ONLY)
-- ============================================
-- Comments and analysis on experiments
-- Separate from immutable experiment data

CREATE TABLE IF NOT EXISTS annotations (
  id BIGSERIAL PRIMARY KEY,
  experiment_id TEXT NOT NULL REFERENCES experiments(experiment_id),
  contributor TEXT NOT NULL,
  annotation_type TEXT NOT NULL CHECK (annotation_type IN ('comment', 'analysis', 'correction', 'link')),
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- INDEXES
-- ============================================
CREATE INDEX IF NOT EXISTS idx_experiments_timestamp ON experiments(timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_experiments_experiment_id ON experiments(experiment_id);
CREATE INDEX IF NOT EXISTS idx_experiments_hardware_id ON experiments(hardware_id);
CREATE INDEX IF NOT EXISTS idx_experiments_task_type ON experiments((task->>'type'));
CREATE INDEX IF NOT EXISTS idx_experiments_success ON experiments((outcome->>'success'));
CREATE INDEX IF NOT EXISTS idx_experiments_failure_mode ON experiments((outcome->>'failure_mode'));
CREATE INDEX IF NOT EXISTS idx_annotations_experiment ON annotations(experiment_id);

-- ============================================
-- ROW LEVEL SECURITY
-- ============================================
ALTER TABLE experiments ENABLE ROW LEVEL SECURITY;
ALTER TABLE annotations ENABLE ROW LEVEL SECURITY;

-- Experiments: READ and INSERT only (NO UPDATE, NO DELETE)
CREATE POLICY "experiments_select" ON experiments FOR SELECT USING (true);
CREATE POLICY "experiments_insert" ON experiments FOR INSERT WITH CHECK (true);
-- NO UPDATE POLICY = immutable records
-- NO DELETE POLICY = permanent records

-- Annotations: READ and INSERT only
CREATE POLICY "annotations_select" ON annotations FOR SELECT USING (true);
CREATE POLICY "annotations_insert" ON annotations FOR INSERT WITH CHECK (true);

-- ============================================
-- VIEWS
-- ============================================

-- View: Failures first (default view)
CREATE OR REPLACE VIEW experiments_failures_first AS
SELECT * FROM experiments
ORDER BY 
  (outcome->>'success')::boolean ASC,  -- failures first
  timestamp DESC;

-- View: By failure mode
CREATE OR REPLACE VIEW experiments_by_failure_mode AS
SELECT 
  outcome->>'failure_mode' as failure_mode,
  COUNT(*) as count,
  AVG(reward) as avg_reward,
  array_agg(experiment_id) as experiment_ids
FROM experiments
WHERE (outcome->>'success')::boolean = false
GROUP BY outcome->>'failure_mode';

-- View: Cross-hardware comparison
CREATE OR REPLACE VIEW experiments_by_hardware AS
SELECT 
  hardware_id,
  hardware->>'platform' as platform,
  hardware->>'mcu' as mcu,
  COUNT(*) as experiment_count,
  SUM(CASE WHEN (outcome->>'success')::boolean THEN 1 ELSE 0 END) as successes,
  SUM(CASE WHEN NOT (outcome->>'success')::boolean THEN 1 ELSE 0 END) as failures,
  AVG(reward) as avg_reward
FROM experiments
GROUP BY hardware_id, hardware->>'platform', hardware->>'mcu';

-- ============================================
-- RATE LIMITING (anti-spam)
-- ============================================
-- Limit: 10 experiments per contributor per hour

CREATE OR REPLACE FUNCTION check_rate_limit()
RETURNS TRIGGER AS $$
BEGIN
  IF (
    SELECT COUNT(*) 
    FROM experiments 
    WHERE contributor = NEW.contributor 
    AND created_at > NOW() - INTERVAL '1 hour'
  ) >= 10 THEN
    RAISE EXCEPTION 'Rate limit exceeded: max 10 experiments per hour per contributor';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_rate_limit
  BEFORE INSERT ON experiments
  FOR EACH ROW
  EXECUTE FUNCTION check_rate_limit();
