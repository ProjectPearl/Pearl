# Debugging Submission Issues

## The Problem
Table is empty - data isn't being saved to Supabase.

## Step 1: Check Browser Console

1. Go to: http://localhost:8000/submit.html
2. Press **F12** to open Developer Tools
3. Click **Console** tab
4. Fill out and submit the form
5. Look for:
   - "Submitting experiment:" (should show your data)
   - "Supabase response:" (should show success or error)
   - Any red error messages

## Step 2: Common Issues

### Issue 1: RLS Policy Problem
**Error:** "new row violates row-level security policy"

**Fix:**
1. In Supabase, go to **Table Editor** → **experiments** table
2. Click **RLS policies** button (top right)
3. Make sure you have:
   - "Allow public insert" policy
   - "Allow public read access" policy
4. If missing, run this SQL:

```sql
-- Allow public insert
CREATE POLICY "Allow public insert" ON experiments
  FOR INSERT WITH CHECK (true);

-- Allow public read
CREATE POLICY "Allow public read access" ON experiments
  FOR SELECT USING (true);
```

### Issue 2: CORS Error
**Error:** "Failed to fetch" or CORS error

**Fix:**
- Make sure you're accessing via `http://localhost:8000` (not `file://`)
- Check Supabase → Settings → API → Allowed Origins

### Issue 3: Table Doesn't Exist
**Error:** "relation does not exist"

**Fix:**
- Run the SQL from `CREATE_TABLE.sql` again in Supabase SQL Editor

## Step 3: Test Directly

Open browser console (F12) and run:

```javascript
// Test Supabase connection
supabaseClient.from('experiments').select('count').then(console.log)

// Try inserting test data
supabaseClient.from('experiments').insert([{
  experiment_id: 'test_direct',
  timestamp: new Date().toISOString(),
  hardware: { platform: 'test', sensors: [], actuators: [] },
  sensors: {},
  actions: [],
  outcome: { success: true, duration_seconds: 1 },
  reward: 1
}]).then(console.log)
```

This will show you exactly what's happening.

## Quick Fix Checklist

- [ ] Browser console shows no errors
- [ ] RLS policies exist (check in Supabase)
- [ ] Table exists (check Table Editor)
- [ ] Config.js has correct credentials
- [ ] Using http://localhost (not file://)

