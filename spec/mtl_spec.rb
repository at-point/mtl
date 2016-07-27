require 'spec_helper'

require 'json'
require 'mtl/version'

RSpec.describe Mtl do
  let(:materialize_version) do
    JSON.parse(File.read('node_modules/materialize-css/package.json'))['version']
  end

  let(:icons_version) do
    JSON.parse(File.read('node_modules/material-design-icons/package.json'))['version']
  end

  let(:lodash_version) do
    JSON.parse(File.read('node_modules/lodash/package.json'))['version']
  end

  it 'has a version number' do
    expect(subject::VERSION).not_to be nil
  end

  it 'has a MATERIALIZE_VERSION' do
    expect(subject::MATERIALIZE_VERSION).to eq materialize_version
  end

  it 'has a ICONS_VERSION' do
    expect(subject::ICONS_VERSION).to eq icons_version
  end

  it 'has a LODASH_VERSION' do
    expect(subject::LODASH_VERSION).to eq lodash_version
  end
end
