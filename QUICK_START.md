# Quick Start - Test in 2 Minutes

## Option 1: Test Without Database (Fastest)

1. **Open the web interface**:
   ```bash
   # From project root
   cd web
   python3 -m http.server 8000
   ```
   
   Or just double-click `web/index.html` in your file browser.

2. **Test form validation**:
   - Go to `submit.html`
   - Try submitting empty form → should show validation errors
   - Fill out form → should show "Supabase not configured" (this is OK)

3. **Test JSON upload**:
   - In submit form, click "Upload JSON file"
   - Select `experiments/0001_balance_bot/results.json`
   - Form should auto-fill with data

**✅ If this works, your basic setup is correct!**

---

## Option 2: Test With Database (Full Test)

### Prerequisites (5 minutes)

1. **Create Supabase account**: https://supabase.com
2. **Create new project**
3. **Get credentials**: Settings → API
4. **Create table**: Run SQL from `SETUP.md`

### Configure

1. Edit `web/config.js`:
   ```javascript
   const SUPABASE_CONFIG = {
     url: 'https://your-project.supabase.co',
     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
   };
   ```

### Test

1. **Start local server**:
   ```bash
   cd web
   python3 -m http.server 8000
   ```

2. **Open browser**: http://localhost:8000

3. **Submit test experiment**:
   - Go to `submit.html`
   - Fill out form
   - Click submit
   - Should see green success message

4. **View experiment**:
   - Go to `experiments.html`
   - Your experiment should appear

**✅ If this works, everything is working!**

---

## Quick Test Script

Run the automated test:

```bash
./test-local.sh
```

This checks:
- ✅ All files are present
- ✅ Schema is correct
- ✅ Config status

---

## Troubleshooting

### "Supabase not configured"
- **OK for local testing** - form validation still works
- To test database: follow `SETUP.md`

### CORS errors
- Use local server (not `file://`)
- Check Supabase allowed origins

### Form doesn't submit
- Open browser console (F12)
- Check for JavaScript errors
- Verify Supabase credentials

### Can't see experiments
- Check Supabase table has data
- Check browser console for errors
- Verify network requests in DevTools

---

## What "Working" Means

✅ **Basic working**:
- Pages load
- Form validation works
- JSON upload works
- Schema validation works

✅ **Fully working**:
- All of above, PLUS:
- Data submits to Supabase
- Experiments appear in browser
- Data stored in database

---

## Next Steps

Once it's working:
1. Submit a real experiment
2. View it in `experiments.html`
3. Check insights in `docs/insights/`
4. Share with others!

