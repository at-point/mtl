require 'rails'
require 'materializer/version'
require 'materializer/rails/header_helper'

module Materializer
  class Engine < ::Rails::Engine
    initializer 'materializer.assets.precompile' do |app|
      %w{stylesheets javascripts fonts}.each do |sub|
        app.config.assets.paths << root.join('vendor', 'assets', sub).to_s
      end
    end

    initializer 'materializer.view_helpers' do
      ActionView::Base.send :include, Materializer::Rails::HeaderHelper
    end
  end
end
