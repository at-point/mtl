require 'spec_helper'
require 'simple_form'
require 'mtl/simple_form/suffix'

RSpec.describe SimpleForm::Components::Suffix, dom: true do
  subject { ActionView::Base.new }
  before do
    subject.instance_variable_set(:'@virtual_path', 'leads/dashboard')
    subject.view_paths = %w{app/views}
    subject.send(:extend, SimpleForm::ActionViewExtensions::FormHelper)
    subject.instance_eval do
      def self.protect_against_forgery?
        false
      end
    end
  end

  def input_for(object, attribute_name, options = {})
    subject.simple_form_for object, url: '' do |f|
      f.input attribute_name, options
    end
  end

  it 'adds nothing if :suffix is not present (or empty)' do
    expect(input_for(:amount, :number, suffix: '')).to_not include('suffix')
  end

  it 'adds .has-suffix to input wrapper' do
    expect(input_for(:amount, :number, suffix: 'CHF')).to contain_dom '<div class="string required has-suffix amount_number">'
  end

  it 'adds the div.suffix to the wrapper' do
    expect(input_for(:amount, :number, suffix: 'CHF')).to contain_dom '<div class="suffix">CHF</div>'
  end

  it 'passes :suffix_html to the div for additional options' do
    expect(input_for(:amount, :number, suffix: 'CHF', suffix_html: { class: 'red-text' })).to contain_dom '<div class="red-text suffix">CHF</div>'
  end
end
