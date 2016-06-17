require 'spec_helper'

require 'json'
require 'materializer/version'

RSpec.describe Materializer do
  let(:materialize_version) {
    JSON.parse(File.read('node_modules/materialize-css/package.json'))['version']
  }

  let(:icons_version) {
    JSON.parse(File.read('node_modules/material-design-icons/package.json'))['version']
  }

  it 'has a version number' do
    expect(Materializer::VERSION).not_to be nil
  end

  it 'has a MATERIALIZE_VERSION' do
    expect(Materializer::MATERIALIZE_VERSION).to eq materialize_version
  end

  it 'has a ICONS_VERSION' do
    expect(Materializer::ICONS_VERSION).to eq icons_version
  end
end
