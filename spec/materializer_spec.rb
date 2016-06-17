require 'spec_helper'

require 'json'
require 'materializer/version'

RSpec.describe Materializer do
  let(:materialize_version) do
    JSON.parse(File.read('node_modules/materialize-css/package.json'))['version']
  end

  let(:icons_version) do
    JSON.parse(File.read('node_modules/material-design-icons/package.json'))['version']
  end

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
