$.rails.href = (element) ->
  element.data('mtl-href') || element[0].href

$(document).on 'click', '[data-mtl-href], [data-confirm]:not(a), [data-method]:not(a)', (e) ->
  link = $(this)
  method = link.data('method')

  return $.rails.stopEverything(e) if !$.rails.allowAction(link)

  if method
    $.rails.handleMethod link
    return $.rails.stopEverything(e)

  if Turbolinks?.supported?
    Turbolinks.visit($(this).data('mtl-href'))
  else
    window.location.href = $(this).data('mtl-href')

$(document).on 'click', '[data-mtl-href]', (ev) ->

$(document).on 'click', '[data-mtl-href] a', (ev) ->
  ev.stopPropagation()

$(document).on 'click', '[data-mtl-submit]', (ev) ->
  ev.preventDefault()
  selector = $(this).data('mtl-submit')
  $(selector).submit()
