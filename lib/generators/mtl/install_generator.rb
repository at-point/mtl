require 'rails'

module Mtl
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.join File.dirname(__FILE__), 'templates'
      class_option :simple_form, type: :boolean, default: true

      # @!visibility private
      def copy_stylesheets
        template 'mtl.scss',        'app/assets/stylesheets/mtl.scss'
        template '_color.scss',     'app/assets/stylesheets/mtl/_color.scss'
        template '_variables.scss', 'app/assets/stylesheets/mtl/_variables.scss'

        return unless options['simple_form']
        template 'simple_form.rb', 'config/initializers/simple_form.rb'
      end
    end
  end
end
