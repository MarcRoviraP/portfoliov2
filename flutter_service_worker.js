'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"assets/fonts/MaterialIcons-Regular.otf": "83e48a20c9774855889a4f1bceb2a1d4",
"assets/AssetManifest.bin.json": "71dfd4058b71de79c15b24ab82ab4365",
"assets/AssetManifest.bin": "479e0bb0bcc2b1d7aeb3be1323fb91b0",
"assets/AssetManifest.json": "0ba8647ed64079571f32366f287b38ca",
"assets/assets/img/hundir_la_flota.png": "05397ec6e555f376dea85ef044b6fe8d",
"assets/assets/img/blackjack.png": "a5d3dda24f2933064cc9c220b294d0e9",
"assets/assets/img/marc.png": "5a19ae1451b0a8b0fa6d432f456317b2",
"assets/assets/img/spaceinvaders.png": "b56d7640ab827698d57bba55af8f50a6",
"assets/assets/img/background_card.png": "a61449fd7789edf1532f0733ffabec18",
"assets/assets/img/calculator.png": "084bea981c1ac0a7c7e9a5869a3647b4",
"assets/assets/img/me.png": "1b97d51b456fab56d3cfc927e7665d63",
"assets/assets/img/chess.png": "1c8c753632be5a90a0403cc58d3acf74",
"assets/assets/img/shoptogether.png": "ee0aa39e962c475152869fddf1737640",
"assets/assets/img/mybusiness.png": "312c1f13a2afaacec7f9376b71511296",
"assets/assets/translations/es.json": "45a53f935d66444b1808c1b02729c9c5",
"assets/assets/translations/en.json": "affc985b8a8a75c0b1f263302870130d",
"assets/assets/data/experiencia_es.json": "da8540aa8b71cc19e4def85f39a45e3f",
"assets/assets/data/proyecto_es.json": "ca531ec824445b48eebed54181085422",
"assets/assets/data/experiencia_en.json": "c5214b03ca49f206f6cbf033f5917dc2",
"assets/assets/data/proyecto_en.json": "383eb253af667900e26658df9831012b",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "cdfb02dea76c7baa84be0f84d2214927",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "eca8a92bb752200f34b52bbdac168b20",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/FontManifest.json": "3ddd9b2ab1c2ae162d46e3cc7b78ba88",
"assets/NOTICES": "7f7c8c5fedf1ec750504cefe44294f47",
"main.dart.js": "342ffb3c493f70fce4a52ee05ed08cd5",
"manifest.json": "71a8e733437d44263d5fab8de4d418dc",
"version.json": "f41ec2a39252549ca9f6fc58a75ed9bf",
"canvaskit/skwasm.js.symbols": "ffc07b382ae1e2cf61303ec4391ea4ad",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/skwasm_heavy.js.symbols": "b68a224b193a61133813a90fe58898a6",
"canvaskit/skwasm.wasm": "11199b1ab0318df784d266b683cf5b5e",
"canvaskit/canvaskit.wasm": "5a48c3461a11f40f5cc2e152558af3e7",
"canvaskit/canvaskit.js.symbols": "e3cc169dd15213381373db1f9ef39f3e",
"canvaskit/skwasm_heavy.wasm": "126e7cd71ed5dc8161d5210ee14db260",
"canvaskit/skwasm.js": "4087d5eaf9b62d309478803602d8e131",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "79d736074b25feb64730127812c13239",
"canvaskit/chromium/canvaskit.js.symbols": "8fce22f4d72ad11f225a4999cd247660",
"canvaskit/skwasm_heavy.js": "dddba7cbf636e5e28af8de827a6e5b49",
"flutter_bootstrap.js": "350b272bb48a72abe59702f89ca62bb5",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"index.html": "f5d02971cac423b49c2434ca9ecc76a1",
"/": "f5d02971cac423b49c2434ca9ecc76a1",
"flutter.js": "2a09505589bbbd07ac54b434883c2f03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
