module Mtl
  module Rails
    # Small helper to render icons using the materialize font.
    #
    # ### Examples
    #
    # ```erb
    # <%= mtl_icon :cloud # renders a "cloud" icon %>
    # <%= mtl_icon :cloud, size: :large # renders a large cloud icon %>
    #
    # <%= mtl_icon :alert, class: 'right red' # add custom classes %>
    # ```
    #
    # @see https://design.google.com/icons/ List of available icons
    # @see http://materializecss.com/icons.html MaterialCSS: Icons
    module IconHelper
      ICON_CLASS = 'material-icons'.freeze

      # Renders an `<i class="material-icons">icon</i>` tag to display an icon.
      #
      # @param icon [Symbol] name of the icon to render, note that these are
      #        usually underscored, like e.g. `:aspect_ratio`
      # @option options [:tiny, :small, :medium, :large] :size
      # @param options [Hash] additional options passed to `content_tag`
      def mtl_icon(icon, options = {})
        options[:class] = [ICON_CLASS, options.delete(:size), options[:class]].compact
        content_tag :i, icon, options
      end
    end
  end
end
