require 'rails'
require 'mtl/version'
require 'mtl/rails/header_helper'

module Mtl
  #:nodoc:
  class Engine < ::Rails::Engine
    initializer 'mtl.assets.precompile' do |app|
      %w{stylesheets javascripts fonts}.each do |sub|
        app.config.assets.paths << root.join('vendor', 'assets', sub).to_s
      end
    end

    initializer 'mtl.view_helpers' do
      ActionView::Base.send :include, Mtl::Rails::HeaderHelper
    end
  end
end
