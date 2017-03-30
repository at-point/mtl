module Mtl
  module Rails
    # Private
    # Specialised renderer for the file card element used in a file collection
    class NavbarPresenter
      attr_reader :view

      def initialize(view)
        @view = view
        @extended_block = nil
      end

      def render(options = {}, &block)
        nav = view.content_tag :nav, view.safe_join([render_main(&block), render_extended].compact),
                               class: @extended_block ? 'nav-extended' : nil

        nav = view.content_tag :div, nav, class: 'navbar-fixed' if options[:fixed]
        nav
      end

      def extended(&block)
        @extended_block = block
        nil
      end

      private

      def render_main(&block)
        view.content_tag(:div, view.capture(self, &block), class: 'nav-wrapper')
      end

      def render_extended
        view.content_tag(:div, view.capture(&@extended_block), class: 'nav-content') if @extended_block
      end
    end
  end
end
