-- Test inserting data directly into the table
-- This will verify the table and policies work

INSERT INTO experiments (
  experiment_id,
  timestamp,
  contributor,
  hardware,
  sensors,
  actions,
  outcome,
  reward
) VALUES (
  'test_direct_insert',
  NOW(),
  'test_user',
  '{"platform": "ESP32", "sensors": ["test"], "actuators": ["test"]}'::jsonb,
  '{}'::jsonb,
  '[]'::jsonb,
  '{"success": true, "duration_seconds": 1}'::jsonb,
  1.0
);

-- Check if it was inserted
SELECT * FROM experiments WHERE experiment_id = 'test_direct_insert';

