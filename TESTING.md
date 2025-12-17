# Testing Guide

## Quick Test (5 minutes)

### Step 1: Check Files Are Present

```bash
# From project root
ls web/submit.html
ls web/experiments.html
ls web/config.js
ls schema/experiment_schema.json
```

All files should exist.

### Step 2: Test Without Database (Local Validation)

1. Open `web/submit.html` in your browser
2. Fill out the form:
   - Experiment ID: `test_001`
   - Contributor: `your-username`
   - Platform: `ESP32`
   - Sensors: `MPU6050`
   - Actuators: `DC motor`
   - Success: `Yes`
   - Duration: `10`
   - Reward: `10.5`
3. Click "Submit Experiment"
4. **Expected**: You should see an error message about Supabase not being configured (this is OK for now)

**What this tests**: Form validation and JSON schema validation work locally.

---

## Full Test (With Supabase)

### Prerequisites

- Supabase account (free tier is fine)
- Supabase project created
- Database table created (see `SETUP.md`)

### Step 1: Configure Supabase

1. Open `web/config.js`
2. Add your Supabase credentials:

```javascript
const SUPABASE_CONFIG = {
  url: 'https://your-project.supabase.co',  // Your actual URL
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',  // Your actual key
};
```

3. Save the file

### Step 2: Test Submission

1. Open `web/submit.html` in browser (use `file://` or local server)
2. Fill out the form completely
3. Click "Submit Experiment"
4. **Expected**: Green success message with experiment ID

### Step 3: Test Viewing

1. Open `web/experiments.html` in browser
2. **Expected**: Your submitted experiment appears in the list
3. Check that all fields display correctly

### Step 4: Verify in Supabase

1. Go to Supabase dashboard
2. Navigate to **Table Editor** → `experiments`
3. **Expected**: Your experiment data is stored in the database

---

## Testing Checklist

### Basic Functionality

- [ ] `web/submit.html` loads without errors
- [ ] `web/experiments.html` loads without errors
- [ ] Form validation works (try submitting empty form)
- [ ] JSON file upload works (try uploading `experiments/0001_balance_bot/results.json`)

### With Supabase

- [ ] Config file has valid credentials
- [ ] Submission succeeds
- [ ] Success message appears
- [ ] Experiment appears in `experiments.html`
- [ ] Data appears in Supabase table

### Schema Validation

- [ ] Missing required fields show error
- [ ] Invalid data types show error
- [ ] Valid data submits successfully

---

## Common Issues

### "Supabase not configured" error

**Fix**: Add credentials to `web/config.js`

### "Database table not found" error

**Fix**: Run the SQL from `SETUP.md` in Supabase SQL Editor

### CORS errors

**Fix**: 
- Make sure you're accessing via `http://localhost` or deployed domain
- Check Supabase → Settings → API → Allowed Origins

### Form doesn't submit

**Check**:
- Browser console for JavaScript errors (F12)
- Network tab to see if request is sent
- Supabase logs for errors

### Experiments don't appear

**Check**:
- Supabase table has data
- Browser console for errors
- Network tab for failed requests

---

## Quick Local Server (Recommended)

Instead of opening files directly, use a local server:

### Python (if installed)

```bash
cd web
python3 -m http.server 8000
```

Then open: `http://localhost:8000`

### Node.js (if installed)

```bash
cd web
npx http-server -p 8000
```

### VS Code

- Install "Live Server" extension
- Right-click `index.html` → "Open with Live Server"

---

## Test Data

Use the example experiment for testing:

```bash
# Copy example to test
cp experiments/0001_balance_bot/results.json test_data.json
```

Then upload `test_data.json` via the form's file upload.

---

## Automated Testing (Future)

We'll add automated tests later. For now, manual testing is sufficient.

