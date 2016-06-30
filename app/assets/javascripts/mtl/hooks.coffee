# Hooks for Turbolinks / jQuery et all

MTL.onReady ->
  # Hooks to data-mtl-nav
  $('[data-mtl-nav="side"]').each -> $(this).sideNav()

# Things to run only once via on('ready') and need to be re-run in turbolinks
MTL.onTurbolinksLoad ->
  Materialize.updateTextFields()
  Waves.displayEffect()
