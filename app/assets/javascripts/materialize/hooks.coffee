# Hooks for Turbolinks / jQuery et all

initSideNavs = ->
  $('[data-materializer="side-nav"]').each -> $(this).sideNav()

event = if window.Turbolinks? then 'turbolinks:load' else 'ready'
$(document).on event, ->
  initSideNavs()
