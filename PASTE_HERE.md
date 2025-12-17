# Where to Paste Code - Step by Step

## Part 1: Supabase Configuration (in `web/config.js`)

### Step 1: Get Your Supabase Credentials

1. Go to https://supabase.com and sign in
2. Create a new project (or use existing)
3. Go to **Settings** → **API**
4. You'll see two things:
   - **Project URL**: `https://xxxxx.supabase.co`
   - **anon public key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...` (long string)

### Step 2: Open `web/config.js`

1. Open the file: `/Volumes/MY SANDISK/PEARL 2/web/config.js`
2. You'll see this:

```javascript
const SUPABASE_CONFIG = {
  url: '', // Your Supabase project URL (e.g., 'https://xxxxx.supabase.co')
  anonKey: '', // Your Supabase anon/public key
};
```

### Step 3: Paste Your Credentials

Replace the empty strings with your actual values:

```javascript
const SUPABASE_CONFIG = {
  url: 'https://your-actual-project-id.supabase.co',  // ← Paste your Project URL here
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.your-actual-key-here',  // ← Paste your anon key here
};
```

**Example:**
```javascript
const SUPABASE_CONFIG = {
  url: 'https://abcdefghijklmnop.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiY2RlZmdoaWprbG1ub3AiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTYzOTU2Nzg5MCwiZXhwIjoxOTU1MTQzODkwfQ.abc123xyz789',
};
```

**Save the file!**

---

## Part 2: SQL Code (in Supabase Dashboard)

### Step 1: Open Supabase SQL Editor

1. In your Supabase dashboard
2. Click **SQL Editor** in the left sidebar
3. Click **New query**

### Step 2: Paste This SQL Code

Copy and paste this entire block:

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

### Step 3: Run the SQL

1. Click **Run** button (or press Cmd+Enter / Ctrl+Enter)
2. You should see: "Success. No rows returned"

---

## How It Works

### The Flow:

1. **User fills form** → `web/submit.html`
2. **Form validates** → Checks against `schema/experiment_schema.json`
3. **JavaScript sends data** → Uses `config.js` to connect to Supabase
4. **Supabase stores data** → Saves to `experiments` table
5. **User views data** → `web/experiments.html` fetches from Supabase

### Without Supabase (Current State):

- ✅ Form validation works
- ✅ JSON upload works
- ❌ Data doesn't save (shows "Supabase not configured")
- ❌ Can't view experiments

### With Supabase (After Setup):

- ✅ Form validation works
- ✅ JSON upload works
- ✅ Data saves to database
- ✅ Can view all experiments

---

## Testing After Setup

1. **Open**: http://localhost:8000/submit.html
2. **Fill form** and submit
3. **Should see**: Green success message (not error)
4. **Open**: http://localhost:8000/experiments.html
5. **Should see**: Your submitted experiment in the list

---

## Troubleshooting

**"Supabase not configured" error:**
- Check `web/config.js` has both `url` and `anonKey` filled in
- Make sure there are no extra spaces or quotes
- Refresh the browser page

**"Database table not found" error:**
- Go back to Supabase SQL Editor
- Make sure you ran the SQL code
- Check Table Editor to see if `experiments` table exists

**Still not working?**
- Open browser console (F12)
- Look for error messages
- Check Network tab to see if requests are being sent

