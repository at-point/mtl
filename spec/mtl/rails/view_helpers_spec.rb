require 'spec_helper'
require 'action_view'
require 'mtl/rails/view_helpers'

RSpec.describe Mtl::Rails::ViewHelpers, dom: true do
  subject { ActionView::Base.new }
  before do
    subject.instance_variable_set(:'@virtual_path', 'leads/dashboard')
    subject.view_paths = %w{app/views}
    subject.send(:extend, described_class)
  end

  context '#mtl_header' do
    it 'renders a default header with a translated title and a menu on mobile' do
      allow(subject).to receive(:translate).with('.title', default: 'Menu') { 'Dashboard' }
      expect(subject.mtl_header).to match_dom <<-HTML
        <header class="mtl-layout-default-header">
          <nav>
            <div class="nav-wrapper">
              <a class="mtl-layout-default-header-toggle left hide-on-large-only" data-activates="nav-menu" data-mtl-nav="side" href="#nav-menu">
                <i class="material-icons">menu</i>
              </a>
              <h1 class="page-title">Dashboard</h1>
            </div>
          </nav>
        </header>
      HTML
    end

    it 'skips the menu if menu: false' do
      expect(subject.mtl_header(menu: false)).to_not contain_dom '<i class="material-icons">menu</i>'
    end

    it 'renders a back: link and skips the menu' do
      html = subject.mtl_header(back: '/back-url')
      expect(html).to_not contain_dom '<i class="material-icons">menu</i>'
      expect(html).to contain_dom '<a class="mtl-layout-default-header-back left" href="/back-url"><i class="material-icons">arrow_back</i></a>'
    end

    it 'can pass in a custom title' do
      expect(subject.mtl_header('Dashboard')).to contain_dom '<h1 class="page-title">Dashboard</h1>'
    end

    it 'skips the title if empty' do
      expect(subject.mtl_header(false)).to_not contain_dom '<h1 class="page-title">'
    end

    it 'appends the block if given' do
      expect(subject.mtl_header('Dashboard') { subject.content_tag('div', 'Hello', class: 'foo') })
        .to contain_dom '<h1 class="page-title">Dashboard</h1><div class="foo">Hello</div>'
    end
  end

  context '#mtl_button' do
    it 'renders an <a/> tag as a raised button (.btn)' do
      expect(subject.mtl_button('Save', '/some/url'))
        .to eq '<a class="btn waves-effect waves-light" href="/some/url">Save</a>'
    end

    it 'passes in other option to #link_to' do
      expect(subject.mtl_button('Save', '/some/url', class: 'red', method: :delete))
        .to eq '<a class="btn waves-effect waves-light red" rel="nofollow" data-method="delete" href="/some/url">Save</a>'
    end

    it 'uses Mtl.effects for the effects' do
      allow(Mtl).to receive(:effects) { 'waves-effect waves-red' }
      expect(subject.mtl_button('Save', '/some/url'))
        .to eq '<a class="btn waves-effect waves-red" href="/some/url">Save</a>'
    end
  end

  context '#mtl_button_flat' do
    it 'renders an <a/> tag as a flat button (.btn-flat) [delegates to #mtl_button]' do
      expect(subject.mtl_button_flat('Cancel', '/some/url'))
        .to eq '<a class="btn waves-effect waves-light btn-flat" href="/some/url">Cancel</a>'
    end
  end

  context '#mtl_button_floating' do
    it 'renders an <a/> tag as a floating button (.btn-floating) [delegates to #mtl_button]' do
      expect(subject.mtl_button_floating(:add, '/some/url', class: 'btn-large red'))
        .to eq '<a class="btn waves-effect waves-light btn-floating btn-large red" href="/some/url"><i class="material-icons">add</i></a>'
    end
  end

  context '#mtl_button_more' do
    it 'renders a wrapped flat button with an additional .btn-more class' do
      expect(subject.mtl_button_more('#dropdown', 'data-mtl-dropdown': true, class: 'something'))
        .to eq '<div class="btn-more-wrapper"><a data-mtl-dropdown="true" class="btn waves-effect waves-light btn-flat btn-more something" href="#dropdown"><i class="material-icons tiny">more_vert</i></a></div>'
    end

    it 'accepts :wrapper_class to pass classes to the wrapper' do
      expect(subject.mtl_button_more('#dropdown', wrapper_class: 'something'))
        .to eq '<div class="btn-more-wrapper something"><a class="btn waves-effect waves-light btn-flat btn-more" href="#dropdown"><i class="material-icons tiny">more_vert</i></a></div>'
    end
  end

  context '#mtl_avatar_link' do
    it 'renders an <a/> tag with initials and no image, if none provided' do
      expect(subject.mtl_avatar_link('/url', 'John Doe'))
        .to eq '<a class="avatar waves-effect waves-light" href="/url">JD</a>'
    end

    it 'renders an <a/> tag with initials and an image, if an url is provided' do
      expect(subject.mtl_avatar_link('/url', 'John Doe', '/image_url.png'))
        .to eq '<a class="avatar waves-effect waves-light" href="/url"><img alt="John Doe" src="/image_url.png" />JD</a>'
    end

    it 'renders a small avatar <a/> tag with initials and an image, if size: :small' do
      expect(subject.mtl_avatar_link('/url', 'John Doe', '/image_url.png', size: :small))
        .to eq '<a class="avatar waves-effect waves-light small" href="/url"><img alt="John Doe" src="/image_url.png" />JD</a>'
    end
  end

  context '#mtl_avatar' do
    it 'renders an <span/> tag with initials and no image, if none provided' do
      expect(subject.mtl_avatar('John Doe'))
        .to eq '<span class="avatar">JD</span>'
    end

    it 'renders an <span/> tag with initials and an image, if an url is provided' do
      expect(subject.mtl_avatar('John Doe', '/image_url.png'))
        .to eq '<span class="avatar"><img alt="John Doe" src="/image_url.png" />JD</span>'
    end

    it 'renders a large <span/> tag as an avatar, if size: :large' do
      expect(subject.mtl_avatar('John Doe', nil, size: :large))
        .to eq '<span class="avatar large">JD</span>'
    end
  end

  context '#mtl_avatar_initials' do
    it 'returns the proper initials for a standard name' do
      expect(subject.mtl_avatar_initials('John Doe')).to eq 'JD'
    end

    it 'returns the proper initials for a three words name' do
      expect(subject.mtl_avatar_initials('John Bar Doe')).to eq 'JD'
    end

    it 'returns the proper initials for an email' do
      expect(subject.mtl_avatar_initials('john.doe@example.com')).to eq 'JD'
    end

    it 'returns the proper initials for a long email' do
      expect(subject.mtl_avatar_initials('john-albert.von-doe@example.com')).to eq 'JD'
    end

    it 'returns a single initial for a single name' do
      expect(subject.mtl_avatar_initials('john')).to eq 'J'
    end

    it 'returns a single initial for a single email' do
      expect(subject.mtl_avatar_initials('john@example.com')).to eq 'J'
    end

    it 'returns an empty string when nothins is provided' do
      expect(subject.mtl_avatar_initials('')).to eq ''
    end

    it 'returns an empty string when a malformatted email is provided' do
      expect(subject.mtl_avatar_initials('@example.com')).to eq ''
    end

    it 'returns an empty string when nil is provided' do
      expect(subject.mtl_avatar_initials(nil)).to eq ''
    end
  end

  context '#mtl_icon' do
    it 'renders an icon' do
      expect(subject.mtl_icon(:cloud)).to eq '<i class="material-icons">cloud</i>'
    end

    it 'pass in the size' do
      expect(subject.mtl_icon(:cloud, size: 'large')).to eq '<i class="material-icons large">cloud</i>'
    end

    it 'can pass in custom options like class' do
      expect(subject.mtl_icon(:cloud, class: 'right')).to eq '<i class="material-icons right">cloud</i>'
    end
  end
end
