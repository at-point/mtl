module Mtl
  module Rails
    # Private
    # Specialised renderer for the navbar element
    class HeaderPresenter
      attr_reader :view
      attr_reader :navbar

      delegate :extended, to: :navbar

      def initialize(view)
        @view = view
      end

      def render(options = {}, &block)
        menu(options.delete(:menu)) if options[:menu].presence
        back_to(options.delete(:back)) if options[:back].presence
        title(options.delete(:title)) if options[:title].presence

        options[:class] = ['mtl-layout-default-header', options[:class]].compact.flatten
        fixed = !options.delete(:fixed).nil?

        @user_content = block_given? ? view.capture(self, &block) : nil

        view.content_tag :header, options do
          navbar.render fixed: fixed do
            view.safe_join [ @back_content || @menu_content, @title_content, @user_content ].compact
          end
        end
      end

      def title(content_or_options_with_block = nil, options = nil, &block)
        options = block_given? ? content_or_options_with_block.to_h : options.to_h
        options[:class] = ['page-title', options[:class]].compact.flatten
        @title_content = view.content_tag(:h1, content_or_options_with_block, options, &block)
      end

      def menu(anchor, options = {}, &block)
        options[:class] = ['mtl-layout-default-header-toggle', 'left', 'hide-on-large-only', options[:class]].compact.flatten
        options[:data] = options.fetch(:data, {}).merge(activates: anchor, mtl_nav: 'side')
        @menu_content = view.link_to "##{anchor}", options do
          block_given? ? view.capture(&block) : view.mtl_icon(:menu)
        end
      end

      def back_to(url_or_url_options, html_options = {}, &block)
        html_options[:class] = ['mtl-layout-default-header-back', 'left', html_options[:class]].compact.flatten
        @back_content = view.link_to url_or_url_options, html_options do
          block_given? ? view.capture(&block) : view.mtl_icon(:arrow_back)
        end
      end

      private

      def navbar
        @navbar ||= NavbarPresenter.new(view)
      end
    end
  end
end
