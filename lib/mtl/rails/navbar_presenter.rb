module Mtl
  module Rails
    # Private
    # Specialised renderer for the navbar element
    class NavbarPresenter
      attr_reader :view

      def initialize(view)
        @view = view
        @extended_options = {}
        @extended_block = nil
      end

      def render(options = {}, &block)
        nav = view.content_tag :nav, view.safe_join([render_main(options, &block),
                                                     render_extended(@extended_options, &@extended_block)].compact),
                               class: @extended_block ? 'nav-extended' : nil

        nav = view.content_tag :div, nav, class: 'navbar-fixed' if options[:fixed]
        nav
      end

      def extended(options = {}, &block)
        @extended_options = options
        @extended_block = block
        nil
      end

      private

      def render_main(options = {}, &block)
        view.content_tag(:div, view.capture(self, &block), class: [options[:class], 'nav-wrapper'].flatten)
      end

      def render_extended(options = {}, &block)
        view.content_tag(:div, view.capture(&block), class: [options[:class], 'nav-content'].flatten) if block_given?
      end
    end
  end
end
