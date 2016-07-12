$(document).on 'click', '[data-mtl-href]', (ev) ->
  target = $(this).data('mtl-href')

  if Turbolinks?.supported?
    Turbolinks.visit(target)
  else
    window.location.href = target

$(document).on 'click', '[data-mtl-href] a', (ev) ->
  ev.stopPropagation()
