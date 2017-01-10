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
  $modal.appendTo('body')
  $modal.addClass(modalClass) if modalClass = $el.data('mtl-modal-class')
  $el.prop('href', "##{modalId}")

  initDefaultModal $el,
    ready: -> $modal.load(ds)

initDefaultModal = ($el, options = {}) -> $el.modal(options)

$(document).on 'click', '[data-mtl-modal="close"]', (e) ->
  e.preventDefault()
  $(this).parents('.modal:first').modal('close')

init = -> $('[data-mtl-modal]').each -> initModal($(this))
if Turbolinks? then $(document).on('turbolinks:load', init) else $(init)
