MODAL_IDS = 1
MODAL_TEMPLATE = '
<div class="modal">
  <div class="modal-content modal-loading">
    Loading&hellip;
  </div>
</div>
'

initXhrModal = ($el) ->
  modalId = 'mtl-modal-' + (MODAL_IDS++)
  ds = $el.prop('href')
  $modal = $(MODAL_TEMPLATE).prop('id', modalId)
  $modal.appendTo('body')
  $modal.addClass(modalClass) if modalClass = $el.data('mtl-modal-class')
  $el.prop('href', "##{modalId}")
  $modal.modal ready: -> $modal.load(ds)

$(document).on 'click', '[data-mtl-modal="close"]', (e) ->
  e.preventDefault()
  $(this).parents('.modal:first').modal('close')

init = ->
  $('[data-mtl-modal="inline"]').modal()
  $('[data-mtl-modal="xhr"]').each -> initXhrModal($(this))

if Turbolinks? then $(document).on('turbolinks:load', init) else $(init)
