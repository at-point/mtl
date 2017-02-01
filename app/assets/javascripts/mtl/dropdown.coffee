updateAttrs = ($el) ->
  $el
    .on('click', -> false)
    .attr('data-beloworigin', 'true')
    .attr('data-alignment', alignment($el))
    .attr('data-activates', activator($el))

alignment = ($el) -> $el.data('alignment') || 'right'

activator = ($el) ->
  id = $el.data('activates') || $el.attr('href') || $el.data('mtl-dropdown')
  String(id).replace(/^#/, '')

init = ->
  $('[data-mtl-dropdown]').each ->
    $el = $(this)
    updateAttrs($el).dropdown(constrainWidth: false)
    $el.siblings('input.select-dropdown').on 'mousedown', (e) ->
      e.preventDefault() if e.clientX >= e.target.clientWidth || e.clientY >= e.target.clientHeight

closeAll = ->
  setTimeout -> $('[data-mtl-dropdown]').dropdown('close')

if Turbolinks? then $(document).on('turbolinks:load', init) else $(init)
$(window).on 'resize orientationchange', closeAll
