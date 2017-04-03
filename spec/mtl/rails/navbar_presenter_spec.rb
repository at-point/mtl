require 'spec_helper'
require 'action_view'
require 'mtl/rails/navbar_presenter'
require 'mtl/rails/view_helpers'

RSpec.describe Mtl::Rails::NavbarPresenter, dom: true do
  let(:view) { ActionView::Base.new }
  subject { described_class.new(view) }

  before do
    view.send(:extend, Mtl::Rails::ViewHelpers)
  end

  context '#render' do
    it 'renders a basic navbar with the given content' do
      expect(subject.render { 'Hello' }).to match_dom <<-HTML
        <nav>
          <div class="nav-wrapper">
            Hello
          </div>
        </nav>
      HTML
    end

    it 'renders a basic navbar with the given content and some custom class on the wrapper' do
      expect(subject.render(class: 'custom-class') { 'Hello' }).to match_dom <<-HTML
        <nav>
          <div class="custom-class nav-wrapper">
            Hello
          </div>
        </nav>
      HTML
    end

    it 'renders a fixed navbar with the given content' do
      expect(subject.render(fixed: true) { 'Hello' }).to match_dom <<-HTML
        <div class="navbar-fixed">
          <nav>
            <div class="nav-wrapper">
              Hello
            </div>
          </nav>
        </div>
      HTML
    end

    it 'renders a navbar with the given content and the extended content' do
      expect(subject.render do |nav|
        nav.extended do
          'Hellobis'
        end

        'Hello'
      end).to match_dom <<-HTML
        <nav class="nav-extended">
          <div class="nav-wrapper">
            Hello
          </div>
          <div class="nav-content">
            Hellobis
          </div>
        </nav>
      HTML
    end

    it 'renders a navbar with the given content and the extended content and some custom class on the ext wrapper' do
      expect(subject.render do |nav|
        nav.extended(class: 'custom-bis') do
          'Hellobis'
        end

        'Hello'
      end).to match_dom <<-HTML
        <nav class="nav-extended">
          <div class="nav-wrapper">
            Hello
          </div>
          <div class="custom-bis nav-content">
            Hellobis
          </div>
        </nav>
      HTML
    end

    it 'renders a fixed navbar with the given content and the extended content' do
      expect(subject.render(fixed: true) do |nav|
        nav.extended do
          'Hellobis'
        end

        'Hello'
      end).to match_dom <<-HTML
        <div class="navbar-fixed">
          <nav class="nav-extended">
            <div class="nav-wrapper">
              Hello
            </div>
            <div class="nav-content">
              Hellobis
            </div>
          </nav>
        </div>
      HTML
    end
  end
end
