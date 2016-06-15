require 'spec_helper'
require 'materializer/rails/header_helper'

RSpec.describe Materializer::Rails::HeaderHelper, helper: true do
  subject do
    Module.new { extend Materializer::Rails::HeaderHelper }
  end

  context '#materializer_header' do
    it 'renders something' do
      p subject.materializer_header
    end
  end
end
