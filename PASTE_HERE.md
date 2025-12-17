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

1. Open the file: `web/config.js`
2. You'll see this:

```javascript
const SUPABASE_CONFIG = {
  url: '',      // e.g., 'https://xxxxx.supabase.co'
  anonKey: '',  // e.g., 'eyJhbGciOiJIUzI1NiIs...'
};
```

### Step 3: Paste Your Credentials

Replace the empty strings with your actual values:

```javascript
const SUPABASE_CONFIG = {
  url: 'https://your-actual-project-id.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.your-actual-key-here',
};
```

⚠️ **Do NOT commit real credentials to git!**

**Save the file!**

---

## Part 2: SQL Code (in Supabase Dashboard)

### Step 1: Open Supabase SQL Editor

1. In your Supabase dashboard
2. Click **SQL Editor** in the left sidebar
3. Click **New query**

### Step 2: Use CREATE_TABLE.sql

> ⚠️ **Important**: Use the SQL from `CREATE_TABLE.sql` in this repository.
> Do NOT use any inline SQL from old documentation.

1. Open the file `CREATE_TABLE.sql` in this repository
2. Copy the **entire contents**
3. Paste into the Supabase SQL Editor

The current schema includes:
- `experiment_id` (TEXT) - Unique identifier
- `task` (JSONB) - Task type and description
- `hardware` (JSONB) - Hardware configuration
- `outcome` (JSONB) - Success/failure and duration
- `reward` (NUMERIC) - Reward signal
- Immutability (no UPDATE/DELETE policies)
- Rate limiting (10 experiments/hour per contributor)

### Step 3: Run the SQL

1. Click **Run** button (or press Cmd+Enter / Ctrl+Enter)
2. You should see: "Success. No rows returned"

---

## How It Works

### The Flow:

1. **User fills form** → `web/submit.html`
2. **Form validates** → Checks required fields
3. **JavaScript sends data** → Uses `config.js` to connect to Supabase
4. **Supabase stores data** → Saves to `experiments` table (immutable)
5. **User views data** → `web/experiments.html` shows failures first

### Required Fields:

- `experiment_id` - Format: 0001_name
- `timestamp` - Auto-generated
- `contributor` - GitHub username
- `task` - Type + description (min 10 chars)
- `hardware` - Platform, MCU, motors, power, sensors, actuators
- `outcome` - Success + duration + failure_mode (if failed)
- `reward` - Numeric value

---

## Testing After Setup

1. Start server: `cd web && python3 -m http.server 8080`
2. **Open**: http://localhost:8080/submit.html
3. **Fill form** and submit
4. **Should see**: Green success message
5. **Open**: http://localhost:8080/experiments.html
6. **Should see**: Your submitted experiment

---

## Troubleshooting

**"Supabase not configured" error:**
- Check `web/config.js` has both `url` and `anonKey` filled in
- Hard refresh the browser (Cmd+Shift+R)

**"Database table not found" error:**
- Make sure you ran the SQL from `CREATE_TABLE.sql`
- Check Table Editor to see if `experiments` table exists

**"Column not found" errors:**
- Your database has an old schema
- Drop the table and recreate using `CREATE_TABLE.sql`

**Still not working?**
- Open browser console (Cmd+Option+I on Mac, F12 on Windows)
- Look for error messages
- Check Network tab to see if requests are being sent
