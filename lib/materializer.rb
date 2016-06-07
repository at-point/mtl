require 'rails'
require 'materializer/version'

module Materializer
  class Engine < ::Rails::Engine
    initializer 'materializer.assets.precompile' do |app|
      %w(stylesheets javascripts fonts).each do |sub|
        app.config.assets.paths << root.join('vendor', 'assets', sub).to_s
      end
    end
  end
end
