'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "7e51bb6e479455ca022622903b7d71eb",
"version.json": "6a7edee948f67f06a99d8821daef3c6f",
"index.html": "a539a39491265c4d0a507f9fa0b21649",
"/": "a539a39491265c4d0a507f9fa0b21649",
"main.dart.js": "5ddc9c5f708833cafdf7c9da680bc662",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "db7bea6d0e185782ce8b8335196fd489",
"assets/AssetManifest.json": "a27a58593453333c7d0dc9274cbbb28e",
"assets/NOTICES": "1ac1358eb6a53cb8615836a9457a4c1e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "7ace50a7463bb7cc12ab5f8171264760",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "dababc91a639dd35e4e75f794b7e266f",
"assets/fonts/MaterialIcons-Regular.otf": "33a4beb5bc36f180a4d39635346fb2b4",
"assets/assets/L4.jpg": "a41e63f531849adc1c4ef4620e3f8878",
"assets/assets/ny4.jpg": "2cfaf283e4db2cf9439453e625d2633d",
"assets/assets/L5.jpg": "72b7147772a33e4489c78d4c336f8f54",
"assets/assets/L1.jpg": "d8f4176c37417430fb60353a2ed3095f",
"assets/assets/logokim.jpg": "276759add0f06c687614c71990ffb994",
"assets/assets/ny1.jpg": "5fe55558d0590e146d8a320ea64ed4e9",
"assets/assets/n8.jpg": "376ee7e14993a69d267a8ca1861d6aab",
"assets/assets/praew.jpg": "0f3e7e7f2991b5070e231b4adf77723b",
"assets/assets/L2.jpg": "2af5c2a8a798db64531eabef1cada411",
"assets/assets/kim.jpg": "ec2b5779cabf4ddf28dfb12836cacb80",
"assets/assets/ny2.jpg": "26ed46769c7ec9c89c577b77d4202275",
"assets/assets/ny3.jpg": "33ec967b96400afab023744ac1ca7b26",
"assets/assets/L3.jpg": "9f7eef419c6a70406d97b39e5a6f75c8",
"assets/assets/layout_plan.jpg": "8bdbd8e293dafe9512f8f8f00b8a96a1",
"assets/assets/11.jpg": "cd82397f8462604742e4f1c024007b6d",
"assets/assets/logopraew.jpeg": "2caca7ad9033df2d7a81742dc2c1c7cf",
"assets/assets/22.jpg": "383ce19210878be4e064c75baf6e9253",
"assets/assets/cot4.jpg": "960fb8b00d4aee8f4fb87da97be196fd",
"assets/assets/cot5.jpg": "f9d0ea78c926a43a5ef8b514b306ad33",
"assets/assets/33.jpg": "5bc0b964c24f5f91153f39606bee8f8c",
"assets/assets/cot1.jpg": "2a9b968c243143a8b5afd33e32799b95",
"assets/assets/logofour.jpg": "b8bed94fe6567ed07e16e905b1d55916",
"assets/assets/cot2.jpg": "0f546ee7b303176e7f3c30125bbf6f17",
"assets/assets/cot3.jpg": "4be0ecce10775d5686da20518772284a",
"assets/assets/pa.png": "d4ddad5b78dc413ca47f5a4a42947929",
"assets/assets/b5.jpg": "8dab7afc09c994037d7cf6db42f12279",
"assets/assets/c1.jpg": "87510a78bb8ce35d90ebe4f2404891ac",
"assets/assets/b.jpg": "299beef0a2e85672a754f06bff391288",
"assets/assets/n6.jpg": "ed19dc0db288038e54661d96a19a4d1f",
"assets/assets/z2.jpg": "bba07abacc731eca8801f31d42874dc3",
"assets/assets/n7.jpg": "9b436f8adfb5d158d53b76618948987a",
"assets/assets/c.jpg": "e7a7ec3ee46f6ce11e6703268f4b1dff",
"assets/assets/b4.jpg": "780a2fe69dc0635fb201fbc1b145f1e0",
"assets/assets/c2.jpg": "e0bea3566d43cea5409d9277728c905f",
"assets/assets/a.jpg": "f94e76677833e48f2e77745dce926490",
"assets/assets/n5.jpg": "c99b5b1dd31a82122e160d99c42ab14c",
"assets/assets/z1.jpg": "02eaf0603e15aed7bfb5d7e4587efb18",
"assets/assets/n4.jpg": "1d608b422219ed26345cae702198e0a7",
"assets/assets/c3.jpg": "b994f5af02decba416f5d9978e58d419",
"assets/assets/6.jpg": "5a3cc219fbc5c0d77b231be68263499e",
"assets/assets/d.jpg": "c1825c03d41976bf963d4459c6753813",
"assets/assets/b3.jpg": "1867865e042de4a64609db5974729f0b",
"assets/assets/2.jpg": "5fd5332cb40474f10f8107742634e996",
"assets/assets/44.jpg": "792b8b41173fb5ef0aae8c3ec2e00d63",
"assets/assets/n1.jpg": "317a8d0900641f43da5fb7199442a0f7",
"assets/assets/b2.jpg": "72f466819ce57085e7ecb68aba655a33",
"assets/assets/e.jpg": "517f8f677711d83540d051fdf4f78416",
"assets/assets/n3.jpg": "970bb5c9eab70d065ad314b06d7fe147",
"assets/assets/1.png": "5e72992d1912a4736d749eb0374145d6",
"assets/assets/logoaim.png": "d8c74501e4c8aae90822321ee54c6315",
"assets/assets/n2.jpg": "44c173278ea08dbd296e13a870b7efd2",
"assets/assets/f.jpg": "fcaf5ff742ae3453527ed3cc4a38b4bf",
"assets/assets/b1.jpg": "3148cfcc776a0facc0a9301c511bb456",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
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
