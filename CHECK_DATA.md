# How to Check If Data Was Saved

## Method 1: View in Web App (Easiest)

1. Go to: http://localhost:8000/experiments.html
2. Your experiment should appear as a card
3. ✅ If you see it = Data saved!

## Method 2: Check Supabase Table Editor (Most Reliable)

1. In Supabase dashboard:
   - Click **Table Editor** (left sidebar)
   - Click **experiments** table
2. You should see your data in rows
3. ✅ If you see rows = Data saved!

## Method 3: Query in SQL Editor

1. In Supabase SQL Editor, paste:
   ```sql
   SELECT * FROM experiments ORDER BY created_at DESC LIMIT 5;
   ```
2. Click **Run**
3. ✅ If you see results = Data saved!

## Troubleshooting

**If experiments.html shows "No experiments found":**
- Check browser console (F12) for errors
- Verify Supabase config in `web/config.js`
- Check Supabase Table Editor to see if data is there

**If Table Editor is empty:**
- Check browser console for submission errors
- Verify RLS policies are set correctly
- Try submitting again

**If you see errors:**
- Open browser console (F12)
- Look for red error messages
- Check Network tab for failed requests

