MODAL_IDS = 1
MODAL_TEMPLATE = '
<div class="modal">
  <div class="modal-content modal-loading">
    Loading&hellip;
  </div>
</div>
'

initModal = ($el) ->
  return initXhrModal($el) if $el.data('mtl-modal') == 'xhr'
  return initDefaultModal($el) if $el.data('mtl-modal') == 'default'

initXhrModal = ($el) ->
  modalId = 'mtl-modal-' + (MODAL_IDS++)
  ds = $el.prop('href')
  $modal = $(MODAL_TEMPLATE).prop('id', modalId)
  $modal.insertAfter($el)
  $el.prop('href', "##{modalId}")

  initDefaultModal $el,
    ready: -> $modal.load(ds)

initDefaultModal = ($el, options = {}) -> $el.leanModal(options)

$(document).on 'click', '[data-mtl-modal="close"]', (e) ->
  e.preventDefault()
  $(this).parents('.modal:first').closeModal()

init = -> $('[data-mtl-modal]').each -> initModal($(this))
if Turbolinks? then $(document).on('turbolinks:load', init) else $(init)
