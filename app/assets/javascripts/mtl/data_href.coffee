MTL.onReady ->
  $(document).on 'click', '[data-mtl-href]', (ev) ->
    window.location.href = $(ev.currentTarget).data 'mtl-href'

  $(document).on 'click', '[data-mtl-href] a', (ev) ->
    ev.stopPropagation()
