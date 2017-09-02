# Hooks for Turbolinks / jQuery et all

# Hooks for data-mtl-*
initMtlHooks = ->
  $('[data-mtl-nav="side"]').each -> $(this).sideNav()
  $('[data-mtl-tabs]').tabs()

if Turbolinks? then $(document).on('turbolinks:load', initMtlHooks) else $(initMtlHooks)

# Things to run only once via on('ready') and need to be re-run in turbolinks
$ ->
  $(document).on 'turbolinks:load', ->
    $('.tooltipped').tooltip()
    Materialize.updateTextFields()
    Waves.displayEffect()

    $('.materialize-textarea').each ->
      $textarea = $(this)
      $textarea.data('original-height', $textarea.height())
      $textarea.data('previous-length', $textarea.val().length)
