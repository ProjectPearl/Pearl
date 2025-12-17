# PWA Setup Notes

## Icons Required

The PWA manifest references icon files that need to be created:

- `icon-192.png` - 192x192 pixels
- `icon-512.png` - 512x512 pixels

### Quick Icon Creation

You can create simple icons using:
1. Any image editor (GIMP, Photoshop, etc.)
2. Online tools like [PWA Asset Generator](https://github.com/onderceylan/pwa-asset-generator)
3. Or use a simple colored square with text for now

### Icon Design Suggestions

- Use the project colors: #2c3e50 (dark blue) and #3498db (blue)
- Include a simple robot or gear icon
- Keep it simple and recognizable at small sizes

## Testing PWA

1. Open the site in Chrome/Edge
2. Open DevTools → Application → Service Workers
3. Check that service worker is registered
4. Go to Application → Manifest to verify manifest.json
5. Test offline mode: DevTools → Network → Offline checkbox
6. Try "Add to Home Screen" on mobile

## Deployment Notes

- Service worker only works over HTTPS (or localhost)
- Make sure all paths in sw.js are correct for your deployment
- Update CACHE_VERSION in sw.js when you make changes

