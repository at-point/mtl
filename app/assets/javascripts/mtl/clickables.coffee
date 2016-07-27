$(document).on 'click', '[data-mtl-href]', (ev) ->
  target = $(this).data('mtl-href')

  if Turbolinks?.supported?
    Turbolinks.visit(target)
  else
    window.location.href = target

$(document).on 'click', '[data-mtl-href] a', (ev) ->
  ev.stopPropagation()

$(document).on 'click', '[data-mtl-submit]', (ev) ->
  ev.preventDefault()
  selector = $(this).data('mtl-submit')
  $(selector).submit()
