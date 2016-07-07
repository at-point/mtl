require 'spec_helper'
require 'action_view'
require 'mtl/rails/icon_helper'
require 'mtl/rails/button_helper'

RSpec.describe Mtl::Rails::ButtonHelper, dom: true do
  subject { ActionView::Base.new }
  before do
    subject.send(:extend, Mtl::Rails::IconHelper)
    subject.send(:extend, described_class)
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
end
