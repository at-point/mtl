IMAGE_EXTENSIONS = ['png', 'jpg', 'gif', 'bmp']
MTL.templates.document_modal = """
  <div class="document-modal">
    <div class="document-modal-dimmer"></div>
    <div class="document-modal-header">
      <div class="document-modal-title left white-text">
        <%= MTL.fileIcon(filename, { class: 'left' }) %>
        <%- filename %>
      </div>
      <div class="document-modal-toolbar right">
        <a href="<%- url %>" target="_blank">
          <%= MTL.icon('file_download', { class: 'white-text left' }) %>
        </a>
        <a href="#" data-mtl-document-modal="close">
          <%= MTL.icon('close', { class: 'white-text left' }) %>
        </a>
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
  </div>
"""

MTL.templates.preview_unknown = """
  <div class="no-preview">
    <p class="center">
      <%= MTL.icon('visibility_off', { size: 'large grey-text' }) %>
    </p>
    <a href="<%- url %>" target="_blank" class="btn btn-primary truncate">
      <%= MTL.icon('file_download', { class: 'left' }) %>
      <%- filename %>
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

createPreview = ($container, filename, url) ->
  switch
    when isImage(filename)
      $container.append($('<img/>', { src: url, alt: filename }))
    when isPDF(filename) && PDFObject.supportsPDFs
      PDFObject.embed(url, $container, { width: '800px', height: $(window).height() + 'px' })
    else
      $container.append(MTL.renderTemplate('preview_unknown', { filename: filename, url: url }))

findOrCreateDocumentModal = ->
  return $('<div/>').appendTo('body') unless $('body > .document-modal').first().length
  $('body > .document-modal').first()

initDocumentModal = ($fileCard) ->
  filename = $fileCard.data('mtl-document-name')
  url = $fileCard.prop('href')
  $modal = $(
    MTL.renderTemplate(
      'document_modal',
      filename: filename,
      url: url,
      hasNext: hasNextFileCard($fileCard),
      hasPrev: hasPrevFileCard($fileCard)
    )
  )
  $modal.find('.document-modal-next').on('click', -> initDocumentModal(nextFileCard($fileCard)))
  $modal.find('.document-modal-prev').on('click', -> initDocumentModal(prevFileCard($fileCard)))
  createPreview($modal.find('.document-modal-content'), filename, url)
  findOrCreateDocumentModal().replaceWith($modal)
  $('body').addClass('no-scroll')

closeDocumentModal = ->
  findOrCreateDocumentModal().remove()
  $('body').removeClass('no-scroll')

$(document).on 'click', '[data-mtl-document-modal="open"]', (e) ->
  e.preventDefault()
  initDocumentModal($(e.currentTarget))

$(document).on 'click', '[data-mtl-document-modal="close"]', (e) ->
  e.preventDefault()
  closeDocumentModal()
