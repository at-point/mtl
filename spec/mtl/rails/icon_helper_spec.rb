require 'spec_helper'
require 'action_view'
require 'mtl/rails/icon_helper'

RSpec.describe Mtl::Rails::IconHelper, dom: true do
  subject { ActionView::Base.new }
  before { subject.send(:extend, described_class) }

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
