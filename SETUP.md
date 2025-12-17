# Setup Instructions

## Supabase Database Setup

### Step 1: Create Supabase Project

1. Go to [https://supabase.com](https://supabase.com)
2. Sign up or log in
3. Click "New Project"
4. Choose organization, name your project (e.g., "embodied-learning")
5. Set a database password (save it!)
6. Choose a region close to you
7. Click "Create new project"
8. Wait 2-3 minutes for setup to complete

### Step 2: Get API Credentials

1. In your Supabase project dashboard, go to **Settings** → **API**
2. Copy the **Project URL** (e.g., `https://xxxxx.supabase.co`)
3. Copy the **anon/public key** (starts with `eyJ...`)

### Step 3: Configure the Web App

1. Open `web/config.js`
2. Replace the empty strings with your credentials:

```javascript
const SUPABASE_CONFIG = {
  url: 'https://your-project.supabase.co',  // Your Project URL
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',  // Your anon key
};
```

### Step 4: Create Database Table

1. In Supabase dashboard, go to **SQL Editor**
2. Click "New query"
3. Paste this SQL:

```sql
-- Create experiments table
CREATE TABLE IF NOT EXISTS experiments (
  id BIGSERIAL PRIMARY KEY,
  experiment_id TEXT NOT NULL,
  timestamp TIMESTAMPTZ NOT NULL,
  contributor TEXT,
  hardware JSONB NOT NULL,
  sensors JSONB,
  actions JSONB,
  outcome JSONB NOT NULL,
  reward NUMERIC NOT NULL,
  notes TEXT,
  failures JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_experiments_timestamp ON experiments(timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_experiments_experiment_id ON experiments(experiment_id);

-- Enable Row Level Security (RLS)
ALTER TABLE experiments ENABLE ROW LEVEL SECURITY;

-- Create policy to allow anyone to read
CREATE POLICY "Allow public read access" ON experiments
  FOR SELECT USING (true);

-- Create policy to allow anyone to insert
CREATE POLICY "Allow public insert" ON experiments
  FOR INSERT WITH CHECK (true);
```

4. Click "Run" (or press Cmd/Ctrl + Enter)
5. You should see "Success. No rows returned"

### Step 5: Test It

1. Open `web/submit.html` in your browser
2. Fill out the form and submit
3. Check `web/experiments.html` to see your experiment
4. Or check Supabase dashboard → **Table Editor** → `experiments`

## Troubleshooting

**"Database table not found" error:**
- Make sure you ran the SQL schema in Step 4
- Check that the table name is exactly `experiments` (lowercase)

**"Supabase not configured" error:**
- Make sure you filled in `web/config.js` with your credentials
- Refresh the page after updating config.js

**CORS errors:**
- Supabase handles CORS automatically, but make sure you're accessing via `http://localhost` or your deployed domain
- Add your domain to Supabase → Settings → API → Allowed Origins (if needed)

## Next Steps

- Submit your first experiment!
- View experiments at `web/experiments.html`
- Check out the example experiment in `experiments/0002_navigation_bot/`

