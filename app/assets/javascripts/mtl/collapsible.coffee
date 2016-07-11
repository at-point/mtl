# Hooks for collapsibles, with (external) triggers

createTrigger = ($el) ->
  $target = $($el.data('mtl-collapsible-toggle'))
  currentIdx = $target.find('.collapsible-header.active:first').parent().index()
  if currentIdx == -1
    $target.find('.collapsible-header:first').addClass('active')
    currentIdx = 0
  else if currentIdx > 0
    $el.addClass('active')

  # hide collapsible-header and disable initial animation
  $target.find('.collapsible-header').hide()
  $target.find('.collapsible-header.active:first').siblings().css('display', 'block')

  # enable accordion
  createAccordion $target

  # bind events
  $el.off '.mtl-collapsible'
  $el.on 'click.mtl-collapsible', (e) ->
    e.preventDefault()
    currentIdx = if currentIdx == 0
      $el.addClass('active')
      $target.find('.collapsible-header:last').trigger('click').parent().index()
    else
      $el.removeClass('active')
      $target.find('.collapsible-header:first').trigger('click').parent().index()

createAccordion = ($el) ->
  $el.data('collapsible', 'accordion')
    .collapsible(accordion: true)

createExpandable = ($el) ->
  $el.data('collapsible', 'expandable')
    .collapsible(accordion: false)

MTL.onReady ->
  $('[data-mtl-collapsible="accordion"]').each -> createAccordion($(this))
  $('[data-mtl-collapsible="expandable"]').each -> createExpandable($(this))
  $('[data-mtl-collapsible-toggle]').each -> createTrigger($(this))
