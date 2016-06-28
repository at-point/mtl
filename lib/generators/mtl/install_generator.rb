require 'rails'

module Mtl
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.join File.dirname(__FILE__), 'templates'

      def copy_stylesheets
        template 'mtl.scss',        'app/assets/stylesheets/mtl.scss'
        template '_color.scss',     'app/assets/stylesheets/mtl/_color.scss'
        template '_variables.scss', 'app/assets/stylesheets/mtl/_variables.scss'
      end
    end
  end
end
