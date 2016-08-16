$.rails.href = (element) ->
  element.data('mtl-href') || element[0].href

$(document).on 'click.rails', '[data-confirm]:not(a), [data-method]:not(a)', (e) ->
  link = $(this)
  method = link.data('method')

  return $.rails.stopEverything(e) if !$.rails.allowAction(link)

  if method
    $.rails.handleMethod link
    return $.rails.stopEverything(e)

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
