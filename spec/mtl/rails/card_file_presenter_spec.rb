require 'spec_helper'
require 'action_view'
require 'mtl/rails/card_file_presenter'
require 'mtl/rails/view_helpers'

RSpec.describe Mtl::Rails::CardFilePresenter, dom: true do
  let(:view) { ActionView::Base.new }
  subject { described_class.new(view) }

  before do
    view.send(:extend, Mtl::Rails::ViewHelpers)
  end

  context '#render' do
    it 'renders a basic file card with filename and href' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg')).to match_dom <<-HTML
        <a title="Document Dolorem.jpg" class="card-panel " target="_blank" href="/path/to/file.jpg">
          <span class="truncate">Document Dolorem.jpg</span>
          <span class="secondary">
            <i class="material-icons red-text">image</i>
            JPG
          </span>
        </a>
      HTML
    end

    it 'renders a file card with filename, href and a custom title' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg', title: 'foo')).to match_dom <<-HTML
        <a title="foo" class="card-panel " target="_blank" href="/path/to/file.jpg">
          <strong class="truncate">foo</strong>
          <span class="truncate">Document Dolorem.jpg</span>
          <span class="secondary">
            <i class="material-icons red-text">image</i>
            JPG
          </span>
        </a>
      HTML
    end

    it 'renders a file card with filename, href and a custom type' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg', type: 'bar')).to match_dom <<-HTML
        <a title="Document Dolorem.jpg" class="card-panel " target="_blank" href="/path/to/file.jpg">
          <span class="truncate">Document Dolorem.jpg</span>
          <span class="secondary">
            <i class="material-icons blue-text">insert_drive_file</i>
            BAR
          </span>
        </a>
      HTML
    end

    it 'renders a file card with filename, href and a custom preview' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg', preview: '/path/to/preview.jpg')).to match_dom <<-HTML
        <a title="Document Dolorem.jpg" class="card-panel card-panel-image" style="background-image: url(/path/to/preview.jpg)" target="_blank" href="/path/to/file.jpg">
          <span class="truncate">Document Dolorem.jpg</span>
          <span class="secondary">
            <i class="material-icons red-text">image</i>
            JPG
          </span>
        </a>
      HTML
    end

    it 'renders a file card with filename, href and a custom custom delete' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg', delete: '/path/to/delete/the/file')).to match_dom <<-HTML
        <a title="Document Dolorem.jpg" class="card-panel " target="_blank" href="/path/to/file.jpg">
          <span class="truncate">Document Dolorem.jpg</span>
          <span class="secondary">
            <i class="material-icons red-text">image</i>
            JPG
          </span>
          <i class="material-icons close" data-method="delete" data-mtl-href="/path/to/delete/the/file">close</i>
        </a>
      HTML
    end

    it 'renders a file card with filename, href and a custom custom delete and a confirm' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg', delete: '/path/to/delete/the/file', confirm: 'sure?')).to match_dom <<-HTML
        <a title="Document Dolorem.jpg" class="card-panel " target="_blank" href="/path/to/file.jpg">
          <span class="truncate">Document Dolorem.jpg</span>
          <span class="secondary">
            <i class="material-icons red-text">image</i>
            JPG
          </span>
          <i class="material-icons close" data-method="delete" data-mtl-href="/path/to/delete/the/file" data-confirm="sure?">close</i>
        </a>
      HTML
    end

    it 'renders a file card with filename, href and document modal options' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg', modal: true)).to match_dom <<-HTML
        <div title="Document Dolorem.jpg" class="card-panel " data-mtl-document-modal="open" data-mtl-document-name="Document Dolorem.jpg" data-href="/path/to/file.jpg">
          <span class="truncate">Document Dolorem.jpg</span>
          <span class="secondary">
            <i class="material-icons red-text">image</i>
            JPG
          </span>
          <a title="Document Dolorem.jpg" target="_blank" class="download-link" download="Document Dolorem.jpg" href="/path/to/file.jpg"><i class="material-icons">file_download</i></a>
        </div>
      HTML
    end

    it 'renders a file card with filename, href and custom data attributes' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg', data: { something: '42' })).to match_dom <<-HTML
        <a title="Document Dolorem.jpg" class="card-panel " data-something="42" target="_blank" href="/path/to/file.jpg">
          <span class="truncate">Document Dolorem.jpg</span>
          <span class="secondary">
            <i class="material-icons red-text">image</i>
            JPG
          </span>
        </a>
      HTML
    end

    it 'renders a file card with filename, href, document modal options and custom data attributes' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg', modal: true, data: { something: '42' })).to match_dom <<-HTML
        <div title="Document Dolorem.jpg" class="card-panel " data-something="42" data-mtl-document-modal="open" data-mtl-document-name="Document Dolorem.jpg" data-href="/path/to/file.jpg">
          <span class="truncate">Document Dolorem.jpg</span>
          <span class="secondary">
            <i class="material-icons red-text">image</i>
            JPG
          </span>
          <a title="Document Dolorem.jpg" target="_blank" class="download-link" download="Document Dolorem.jpg" href="/path/to/file.jpg"><i class="material-icons">file_download</i></a>
        </div>
      HTML
    end
  end
end
