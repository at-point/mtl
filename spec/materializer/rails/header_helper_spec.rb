require 'spec_helper'
require 'action_view'
require 'materializer/rails/header_helper'

RSpec.describe Materializer::Rails::HeaderHelper, dom: true do
  subject { ActionView::Base.new }
  before {
    subject.instance_variable_set(:'@virtual_path', 'leads/dashboard')
    subject.view_paths = %w{app/views}
    subject.send(:extend, described_class)
  }

  context '#materializer_header' do
    it 'renders a default header with a translated title and a menu on mobile' do
      allow(subject).to receive(:translate).with('.title', default: 'Menu') { 'Dashboard' }
      expect(subject.materializer_header).to match_dom <<-HTML
        <header class="mtl-layout-default-header z-depth-1">
          <nav>
            <div class="nav-wrapper">
              <a class="left hide-on-large-only" data-activates="nav-menu" data-materializer="side-nav" href="#nav-menu">
                <i class="material-icons">menu</i>
              </a>
              <h1 class="page-title">Dashboard</h1>
            </div>
          </nav>
        </header>
      HTML
    end

    it 'skips the menu if menu: false' do
      expect(subject.materializer_header(menu: false)).to_not contain_dom '<i class="material-icons">menu</i>'
    end

    it 'renders a back: link and skips the menu' do
      html = subject.materializer_header(back: '/back-url')
      expect(html).to_not contain_dom '<i class="material-icons">menu</i>'
      expect(html).to contain_dom '<a class="left" href="/back-url"><i class="material-icons">arrow_back</i></a>'
    end

    it 'can pass in a custom title' do
      expect(subject.materializer_header('Dashboard')).to contain_dom '<h1 class="page-title">Dashboard</h1>'
    end

    it 'skips the title if empty' do
      expect(subject.materializer_header(false)).to_not contain_dom '<h1 class="page-title">'
    end

    it 'appends the block if given' do
      expect(subject.materializer_header('Dashboard') { subject.content_tag('div', 'Hello', class: 'foo') })
        .to contain_dom '<h1 class="page-title">Dashboard</h1><div class="foo">Hello</div>'
    end
  end
end
