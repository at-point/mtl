IMAGE_EXTENSIONS = ['png', 'jpg', 'gif', 'bmp']
MTL.templates.document_modal = """
  <div class="document-modal">
    <div class="document-modal-dimmer" data-mtl-document-modal="close"></div>
    <div class="document-modal-header">
      <div class="document-modal-title left white-text">
        <%= MTL.fileIcon(filename, { class: 'left' }) %>
        <%- title %>
      </div>
      <div class="document-modal-toolbar right">
        <a href="<%- url %>" target="_blank" download="<%- filename %>">
          <%= MTL.icon('file_download', { class: 'white-text left' }) %>
        </a>
        <a href="#" data-mtl-document-modal="close">
          <%= MTL.icon('close', { class: 'white-text left' }) %>
        </a>
      </div>
    </div>

    <div class="document-modal-content">
    </div>

    <% if(hasNext) { %>
      <div class="document-modal-next btn black">
        <%= MTL.icon('keyboard_arrow_right', { class: 'white-text' }) %>
      </div>
    <% } %>

    <% if(hasPrev) { %>
      <div class="document-modal-prev btn black">
        <%= MTL.icon('keyboard_arrow_left', { class: 'white-text' }) %>
      </div>
    <% } %>
  </div>
"""

MTL.templates.no_preview = """
  <div class="no-preview">
    <p class="center">
      <%= MTL.icon('visibility_off', { size: 'large grey-text' }) %>
    </p>
    <a href="<%- url %>" target="_blank" class="btn btn-primary truncate">
      <%= MTL.icon('file_download', { class: 'left' }) %>
      <%- title %>
    </a>
  </div>
"""

nextFileCard = ($fileCard) ->
  $fileCard.next('[data-mtl-document-modal="open"]')

prevFileCard = ($fileCard) ->
  $fileCard.prev('[data-mtl-document-modal="open"]')

hasNextFileCard = ($fileCard) ->
  nextFileCard($fileCard).length > 0

hasPrevFileCard = ($fileCard) ->
  prevFileCard($fileCard).length > 0

fileExtension = (filename) ->
  String(filename).toLowerCase().split('.').pop()

isImage = (filename) ->
  _.includes(IMAGE_EXTENSIONS, fileExtension(filename))

isPDF = (filename) ->
  fileExtension(filename) == 'pdf'

createPreview = ($container, title, filename, url) ->
  switch
    when isImage(filename)
      $container.css 'height', 'auto'
      $container.append($('<img/>', { src: url, alt: filename }))
    when isPDF(filename) && PDFObject.supportsPDFs
      $container.css 'height', '100%'
      $pdfWrapper = $('<div/>').appendTo $container
      PDFObject.embed(url, $pdfWrapper, { width: '800px' })
    else
      $container.css 'height', 'auto'
      data = { title: title, filename: filename, url: url }
      $container.append(MTL.renderTemplate('no_preview', data))

findOrCreateDocumentModal = ->
  return $('<div/>').appendTo('body') unless $('body > .document-modal').first().length
  $('body > .document-modal').first()

initDocumentModal = ($fileCard) ->
  filename = $fileCard.data('mtl-document-name')
  title = $fileCard.prop('title')
  url = $fileCard.prop('href')
  $modal = $(
    MTL.renderTemplate(
      'document_modal',
      filename: filename,
      title: title,
      url: url,
      hasNext: hasNextFileCard($fileCard),
      hasPrev: hasPrevFileCard($fileCard)
    )
  )
  $modal.find('.document-modal-next').on('click', -> initDocumentModal(nextFileCard($fileCard)))
  $modal.find('.document-modal-prev').on('click', -> initDocumentModal(prevFileCard($fileCard)))
  createPreview($modal.find('.document-modal-content'), title, filename, url)
  findOrCreateDocumentModal().replaceWith($modal)
  $('body').addClass('no-scroll')

closeDocumentModal = ->
  findOrCreateDocumentModal().remove()
  $('body').removeClass('no-scroll')
  $(document).off 'keydown.mtl-document-modal'

$(document).on 'click', '[data-mtl-document-modal="open"]', (e) ->
  e.preventDefault()
  initDocumentModal($(e.currentTarget))
  $(document).on 'keydown.mtl-document-modal', (e) ->
    switch e.keyCode
      when 27 # esc
        closeDocumentModal()
      when 37 # left
        findOrCreateDocumentModal().find('.document-modal-prev').trigger 'click'
      when 39 # right
        findOrCreateDocumentModal().find('.document-modal-next').trigger 'click'

$(document).on 'click', '[data-mtl-document-modal="close"]', (e) ->
  e.preventDefault()
  closeDocumentModal()



