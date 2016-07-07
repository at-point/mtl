require 'rails'
require 'mtl/version'

require 'mtl/rails/view_helpers'

# MTL configuration options are as follows:
module Mtl
  # CSS classes added for effects on buttons
  mattr_accessor :effects
  @@effects = 'waves-effect waves-light'

  #:nodoc:
  class Engine < ::Rails::Engine
    initializer 'mtl.assets.precompile' do |app|
      %w{stylesheets javascripts fonts}.each do |sub|
        app.config.assets.paths << root.join('vendor', 'assets', sub).to_s
      end
    end

    initializer 'mtl.view_helpers' do
      ActionView::Base.send :include, Mtl::Rails::ViewHelpers
    end
  end
end
