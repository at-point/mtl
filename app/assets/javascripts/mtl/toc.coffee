TEMPLATE = _.template '''
<li>
  <a href="#<%- id %>"><%- title %></a>
</li>
'''

createTocEntry = ($el) ->
  # Ensure id and get title
  title = $el.data('mtl-section')
  id = $el.prop('id') || "mtl-toc-#{Materialize.guid()}"
  $el.prop('id', id)

  # Render
  TEMPLATE(id: id, title: title)

initToc = ($wrapper) ->
  # Clear
  $wrapper.children().remove()

  # Pin wrapper to top, if data-mtl-toc="pin"
  $wrapper.pushpin(top: $wrapper.offset().top) if $wrapper.data('mtl-toc') == 'pin'

  # Add entries
  $sections = $('[data-mtl-section]').each ->
    $wrapper.append createTocEntry($(this))

  # Enable scrollspy
  $sections.scrollSpy()

init = -> $('[data-mtl-toc]').each -> initToc($(this))
if Turbolinks? then $(document).on('turbolinks:load', init) else $(init)
