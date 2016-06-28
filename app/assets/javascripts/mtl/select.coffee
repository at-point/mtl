prepareSelect = ($el) ->
  val = $el.val()
  index = $el.prop('selectedIndex')

  if !val || val.length == 0 || index == 0
    $el.prop('selectedIndex', 0)
    $el.data('mtl-select:is-all-selected', true)

  $el

createSelectCallback = ($el) ->
  ->
    return unless $el.data('mtl-select') == "multiple"

    $dropdown = $el.prev('.multiple-select-dropdown')
    val = $el.val()
    index = $el.prop('selectedIndex')
    isSelected = $el.data('mtl-select:is-all-selected')

    # 1: Nothing has been selected => select "all"
    if !val || val.length == 0
      $el.data('mtl-select:is-all-selected', true)
      $dropdown.find('li:first').trigger('click')
    # 2: More than one item is selected and previously "all" was selected =>
    #    disable select "all"
    else if val.length > 1 && isSelected
      $el.data('mtl-select:is-all-selected', false)
      $dropdown.find('li:first').trigger('click')
    # 3: More than one item is selected and previously "all" was not selected =>
    #    select "all" again
    else if val.length > 1 && index == 0
      $el.data('mtl-select:is-all-selected', true)
      $dropdown.find('li.active:not(:first)').trigger('click')

MTL.onReady ->
  $('select[data-mtl-select]').each ->
    $this = prepareSelect $(this)
    $this.material_select(createSelectCallback($this))
