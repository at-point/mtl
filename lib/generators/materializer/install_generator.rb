require 'rails'

module Materializer
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.join File.dirname(__FILE__), 'templates'

      def copy_stylesheets
        template 'materialize.scss', 'app/assets/stylesheets/materialize.scss'
        template '_color.scss',      'app/assets/stylesheets/materialize/_color.scss'
        template '_variables.scss',  'app/assets/stylesheets/materialize/_variables.scss'
      end
    end
  end
end
