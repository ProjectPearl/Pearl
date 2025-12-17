# How to Check If Everything Is Running

## Quick Status Check (30 seconds)

### 1. Check if Local Server is Running

**In Terminal:**
```bash
lsof -ti:8000
```

**What you'll see:**
- **A number** (like `12345`) = Server IS running ✅
- **Nothing/empty** = Server is NOT running ❌

**If not running, start it:**
```bash
cd "/Volumes/MY SANDISK/PEARL 2/web"
python3 -m http.server 8000
```

---

### 2. Check if Web Pages Load

**Open in browser:**
- http://localhost:8000/index.html

**What you should see:**
- ✅ **Embodied Learning homepage** = Working!
- ❌ **404 Error** = Server not running or wrong directory
- ❌ **Can't connect** = Server not running

---

### 3. Check if Supabase is Configured

**Open file:**
```
/Volumes/MY SANDISK/PEARL 2/web/config.js
```

**Look for:**
```javascript
const SUPABASE_CONFIG = {
  url: 'https://something.supabase.co',  // ← Should have a URL
  anonKey: 'eyJ...',  // ← Should have a long key
};
```

**Status:**
- ✅ **Both have values** = Configured
- ❌ **Both are empty strings** = Not configured

---

### 4. Test Form Submission

**Steps:**
1. Go to: http://localhost:8000/submit.html
2. Fill out the form
3. Click "Submit Experiment"

**What you'll see:**

**If Supabase NOT configured:**
- ⚠️ Yellow/red message: "Supabase not configured"
- This is OK - form validation still works

**If Supabase IS configured:**
- ✅ Green message: "Experiment submitted successfully!"
- ❌ Red message: "Database table not found" = Need to run SQL

---

### 5. Test Viewing Experiments

**Steps:**
1. Go to: http://localhost:8000/experiments.html
2. Wait for page to load

**What you'll see:**

**If Supabase NOT configured:**
- ⚠️ Message: "Supabase not configured"

**If Supabase IS configured but no data:**
- ℹ️ Message: "No experiments found. Submit the first one!"

**If Supabase IS configured with data:**
- ✅ List of experiments with cards showing details

---

## Complete Status Checklist

Run through this checklist:

- [ ] **Server running?** (`lsof -ti:8000` shows a number)
- [ ] **Homepage loads?** (http://localhost:8000/index.html works)
- [ ] **Submit page loads?** (http://localhost:8000/submit.html works)
- [ ] **Experiments page loads?** (http://localhost:8000/experiments.html works)
- [ ] **Config file has values?** (web/config.js has URL and key)
- [ ] **Form validation works?** (Try submitting empty form - shows errors)
- [ ] **Can submit data?** (Form submits without "Supabase not configured" error)
- [ ] **Can view data?** (experiments.html shows your submitted experiments)

---

## Quick Test Script

Run this in terminal:

```bash
cd "/Volumes/MY SANDISK/PEARL 2"
./test-local.sh
```

This checks:
- ✅ All files exist
- ✅ Schema is correct
- ✅ Config status

---

## Visual Status Indicators

### 🟢 Everything Working:
- Server running
- Pages load
- Supabase configured
- Can submit experiments
- Can view experiments

### 🟡 Partially Working:
- Server running
- Pages load
- Supabase NOT configured
- Form validation works
- Can't save/view data

### 🔴 Not Working:
- Server not running
- 404 errors
- Pages don't load

---

## Common Issues & Fixes

### "404 Not Found"
**Fix:** Server not running or wrong directory
```bash
cd "/Volumes/MY SANDISK/PEARL 2/web"
python3 -m http.server 8000
```

### "Supabase not configured"
**Fix:** Add credentials to `web/config.js`
- Get from Supabase dashboard
- Paste into config.js

### "Database table not found"
**Fix:** Run SQL in Supabase SQL Editor
- Copy SQL from SETUP.md
- Paste in Supabase → SQL Editor
- Click Run

### "Can't connect to localhost"
**Fix:** Server not running
```bash
lsof -ti:8000  # Check if running
# If nothing, start server
```

---

## Browser Console Check

**Open browser console (F12) and look for:**

✅ **Good signs:**
- No red errors
- "Service Worker registered" (for PWA)
- Network requests succeed (200 status)

❌ **Bad signs:**
- Red error messages
- "Failed to fetch"
- CORS errors
- 404 errors

---

## Quick Status Command

**One command to check everything:**

```bash
cd "/Volumes/MY SANDISK/PEARL 2" && \
echo "Server status:" && \
(lsof -ti:8000 > /dev/null && echo "✅ Running on port 8000" || echo "❌ Not running") && \
echo "Files check:" && \
([ -f web/config.js ] && echo "✅ config.js exists" || echo "❌ config.js missing") && \
echo "Config status:" && \
(grep -q "url: ''" web/config.js && echo "⚠️  Supabase not configured" || echo "✅ Supabase configured")
```

This gives you a quick status report!

