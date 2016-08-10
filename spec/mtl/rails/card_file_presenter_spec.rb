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
        <a title="Document Dolorem.jpg" target="_blank" class="card-panel " href="/path/to/file.jpg">
          Document Dolorem.jpg
          <span class="grey-text">
            <i class="material-icons red-text">image</i>
            JPG
          </span>
        </a>
      HTML
    end

    it 'renders a file card with filename, href and a custom title' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg', title: 'foo')).to match_dom <<-HTML
        <a title="foo" target="_blank" class="card-panel " href="/path/to/file.jpg">
          <strong>foo</strong>
          Document Dolorem.jpg
          <span class="grey-text">
            <i class="material-icons red-text">image</i>
            JPG
          </span>
        </a>
      HTML
    end

    it 'renders a file card with filename, href and a custom type' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg', type: 'bar')).to match_dom <<-HTML
        <a title="Document Dolorem.jpg" target="_blank" class="card-panel " href="/path/to/file.jpg">
          Document Dolorem.jpg
          <span class="grey-text">
            <i class="material-icons blue-text">insert_drive_file</i>
            BAR
          </span>
        </a>
      HTML
    end

    it 'renders a file card with filename, href and a custom preview' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg', preview: '/path/to/preview.jpg')).to match_dom <<-HTML
        <a title="Document Dolorem.jpg" target="_blank" class="card-panel card-panel-image"  style="background-image: url(/path/to/preview.jpg)" href="/path/to/file.jpg">
          Document Dolorem.jpg
          <span class="grey-text">
            <i class="material-icons red-text">image</i>
            JPG
          </span>
        </a>
      HTML
    end

    it 'renders a file card with filename, href and a custom preview' do
      expect(subject.render('Document Dolorem.jpg', '/path/to/file.jpg', 'data-mtl-delete' => '/path/to/delete/the/file')).to match_dom <<-HTML
        <a title="Document Dolorem.jpg" target="_blank" class="card-panel "  href="/path/to/file.jpg">
          Document Dolorem.jpg
          <span class="grey-text">
            <i class="material-icons red-text">image</i>
            JPG
          </span>
          <a rel="nofollow" data-method="delete" href="/path/to/delete/the/file"><i class="material-icons close">close</i></a>
        </a>
      HTML
    end
  end
end
