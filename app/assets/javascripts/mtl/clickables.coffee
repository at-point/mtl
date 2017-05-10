oldHref = $.rails.href
$.rails.href = (element) -> element.data('mtl-href') || oldHref(element)

$(document).on 'click', '[data-mtl-href]', (e) ->
  e.preventDefault()
  link = $(this)
  url = $(this).prop('href') || $(this).data('mtl-href')
  method = link.data('method')

  return $.rails.stopEverything(e) if !$.rails.allowAction(link)

  if method
    $.rails.handleMethod link
    return $.rails.stopEverything(e)

  if Turbolinks?.supported?
    Turbolinks.visit(url)
  else
    window.location.href = url

$(document).on 'click', '[data-mtl-href] a', (ev) ->
  ev.stopPropagation()

$(document).on 'click', '[data-mtl-submit]', (ev) ->
  ev.preventDefault()
  selector = $(this).data('mtl-submit')
  $(selector).submit()
