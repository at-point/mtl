# Hooks for Turbolinks / jQuery et all

skipSecond = (cb) ->
  cntr = 0
  ->
    cntr += 1
    cb() if cntr != 2

skipFirst = (cb) ->
  cntr = 0
  ->
    cntr += 1
    cb() if cntr > 1

initSideNavs = ->
  $('[data-mtl="side-nav"]').each -> $(this).sideNav()

initFormLabels = ->
  Materialize.updateTextFields()

initWaves = ->
  Waves.displayEffect()

$(document).on 'ready turbolinks:load', skipSecond ->
  initSideNavs()

$(document).on 'turbolinks:load', skipFirst ->
  initFormLabels()
  initWaves()
