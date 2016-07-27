$(document).on 'click', '[data-mtl-submit]', (ev) ->
  selector = $(this).data('mtl-submit')
  $(selector).submit()
