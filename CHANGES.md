ChangeLog
=========

- refined general radios and positionin [#79]
- made hidden main labels visible again [#79]
- added single line mode for radios [#79]

Version 1.0.0
-------------

:tada: First official release to rubygems, thanks for all your pushes
and fixes!

- Added simple_form compatible error styling [#72, #75]
- Enabled suffix text labels for input fields [#71,#74]
- Add support for custom data attributes on file cards [#73]
- Truncate long file names and titles on file cards [#70]
- Render preview of file cards in a modal dialog [#65]
- Basic template registry for lodash templates [#65]
- PDFObject dependency [#65]
- Removed default table extends to disable coulouring and borders [#64]
- Exposed label styles for the h5 element [#61, #62]
- Introduced JS helpers within MTL namespace (icon helpers) [#60]
- Added file card helper for file collections [#58]
- Added styles for files/downloads collection
- Made side nav width configurable by $mtl-layout-default-sidenav-width and added
  a fix to prevent overlapping of fixed headers. [#54]
- Added `data-mtl-submit` behaviour [#53]
- Made side-nav icons independent from the entry height pro proper spacing between icon and label [#52]
- Bundle lodash.js as part of the mtl.js [#49]
- Removed wierd side-nav divider margin [#51]
- Added custom CSS class support for `mtl_header` [#50]
- Support Rails 5, relax dependency `railities` [#38, #48]
- Used flexbox fix to enable the content area over the full page height [#41]
- Extended default layout coloring variables [#41]
- Added `data-mtl-dropdown` support and proper rendering of more menu buttons
  via `.btn-more-wrapper` and `.btn-more` [#42]
- Added custom class support for XHR modals [#47]
- Updated materialize-css to [171a9ef](https://github.com/Dogfalo/materialize/commit/171a9ef004b3145864ef975baa4cea8c0c06bf11) [#45]
- Prefixed MTL avatar extension to `mtl-avatar` [#46]
- Unify typography / headings to better conform to Material Design [#36, #39, #40]
- Implement ToC based on pushpin and scrollspy [#36]
  This introduces a two new variables to properly style ToCs,
  these are $mtl-toc-text and $mtl-toc-border
- Properly teardown data-mtl-select on turbolinks:before-cache #34
- Add border-radius to .avatar > img to avoid flickering
- Removed MTL.xyz magic, because it really is not required, required a fix
  for http://jquery.com/upgrade-guide/3.0/#breaking-change-on-quot-ready-quot-fn-removed
- Added supoort for tabs via `data-mtl-tabs`
- Added CSS extensions: `.btn-square`, `.no-pad*`, `.scroll-y` and
  additional table styles like `.compressed` [#29]
- Added support for modals via `data-mtl-modal`
- Auto-enhance `<select>`s within simple form `<form>`s [#27]
- Added reference to Mtl::Rails::ViewHelpers, improved documentation on
  .fixed-action-btn within the default layout
- Added `data-mtl-collapsible` and `data-mtl-collapsible-toggle`s [#22, #24]
- Updated to Dogfalo/materialize-css@53c624d
- Added yard / yardoc to document everything
- Added an avatar helper to render user pictures [#17]
- Added javascript support to convert any element into a link [#11]
- Added Rails `mtl_button_floating` helper for big round floating action buttons [#10]
- Added configuration option for effects: `Mtl.effects`, they default to
  `waves-effect waves-light` and are used by all buttons [#7]
- Added `mtl_button` and `mtl_button_flat` helper methods, when using: prefer
  the `mtl_button_flat` method [#7]
- Added `mtl_icon(:cloud)` (alias: `mi`) icon helper to render
  `<i class="material-icons">cloud</i>` tags [#7]
- Added `simple_form.rb` initializer to generator, that creates a basic useable
  simple form configuration, based on
  [patricklindsay/simple_form-materialize](https://github.com/patricklindsay/simple_form-materialize)
  [#5, #7]
- Renamed `data-mtl="side-nav"` to `data-mtl-nav="side"`
- Added `data-mtl-select` and `data-mtl-select="multiple"`, [#6]
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
