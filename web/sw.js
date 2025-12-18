const CACHE_VERSION = 'v3';
const CACHE_NAME = 'pearl-' + CACHE_VERSION;
const OFFLINE_PAGES = [
    './',
    './index.html',
    './experiments.html',
    './submit.html',
    './about.html',
    './styles.css',
    './schema-validator.js',
    './manifest.json',
    './favicon.png',
    './apple-touch-icon.png'
];

self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(CACHE_NAME).then((cache) => {
            return cache.addAll(OFFLINE_PAGES.map(url => new Request(url, { cache: 'reload' })));
        })
    );
    self.skipWaiting();
});

self.addEventListener('activate', (event) => {
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cacheName) => {
                    if (cacheName !== CACHE_NAME) {
                        return caches.delete(cacheName);
                    }
                })
            );
        })
    );
    return self.clients.claim();
});

self.addEventListener('fetch', (event) => {
    if (event.request.method !== 'GET') return;

    if (event.request.mode === 'navigate') {
        event.respondWith(
            fetch(event.request)
                .then((response) => {
                    const responseClone = response.clone();
                    caches.open(CACHE_NAME).then((cache) => {
                        cache.put(event.request, responseClone);
                    });
                    return response;
                })
                .catch(() => {
                    return caches.match(event.request).then((response) => {
                        if (response) return response;
                        return caches.match('./index.html');
                    });
                })
        );
        return;
    }

    event.respondWith(
        caches.match(event.request).then((response) => {
            if (response) return response;
            return fetch(event.request).then((response) => {
                if (!event.request.url.includes('api.github.com') && 
                    !event.request.url.includes('fonts.googleapis.com') &&
                    !event.request.url.includes('fonts.gstatic.com')) {
                    const responseClone = response.clone();
                    caches.open(CACHE_NAME).then((cache) => {
                        cache.put(event.request, responseClone);
                    });
                }
                return response;
            }).catch(() => {
                if (event.request.headers.get('accept')?.includes('text/html')) {
                    return caches.match('./index.html');
                }
            });
        })
    );
});
