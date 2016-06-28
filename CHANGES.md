ChangeLog
=========

Development 0.1.0
------------------

- Renamed `data-mtl="side-nav"` to `data-mtl-nav="side"`
- Added `data-mtl-select` and `data-mtl-select="multiple"`, #6
- Added MTL.onReady/onTurbolinksLoad JS helpers to skip duplicate calls
  or first call when turbolinks is used
- Improve hooks.coffee with a simple turbolinks guard, to ensure it
  is only called once on initial page load. Also added turbolink hook
  for Waves.displayEffect()
- Renamed `materializer` to `mtl`
- Added `materializer_header` helper function to render nice navbars
- REPLACE: vendored `_icons-material-design.scss` with local `_material-icons.scss`,
  that uses the embedded icon font and already contains the additional flags
- Added material-design-icon font from npm, to provide the icon font locally
- Updated to Dogfalo/materialize@607951e
