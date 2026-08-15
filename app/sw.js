/* Pronunciation Workshop — service worker
   Caches the app shell (HTML/PDF page images/icons/hls.js) for offline use.
   Videos are NOT cached here — they stream from Bunny.net on demand. */
const CACHE = 'pw-shell-v3';
const SHELL = [
  './',
  './index.html',
  './course-data.js',
  './manifest.webmanifest',
  './icons/icon-192.png',
  './icons/icon-512.png',
  './pdf-pages/p43.png',
  './pdf-pages/p44.png',
  './pdf-pages/p45.png',
  'https://cdn.jsdelivr.net/npm/hls.js@1/dist/hls.min.js'
];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(SHELL)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys().then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', e => {
  const url = new URL(e.request.url);
  // Never cache video streams (Bunny HLS / mp4) — always go to network.
  if (/\.(m3u8|ts|mp4|m4s|webm)(\?|$)/i.test(url.pathname) || url.hostname.includes('bunny')) {
    return; // default network handling
  }
  // Cache-first for the app shell, fall back to network and cache new GETs.
  e.respondWith(
    caches.match(e.request).then(hit => hit || fetch(e.request).then(res => {
      if (e.request.method === 'GET' && res.ok && url.origin === location.origin) {
        const copy = res.clone();
        caches.open(CACHE).then(c => c.put(e.request, copy));
      }
      return res;
    }).catch(() => hit))
  );
});
