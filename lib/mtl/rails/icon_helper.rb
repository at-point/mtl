module Mtl
  module Rails
    # Icon Helper
    # ===========
    #
    # Small helper to render icons using the materialize font.
    #
    # **Examples**
    # ```erb
    # <%= mtl_icon :cloud # renders a "cloud" icon %>
    # <%= mtl_icon :cloud, size: :large # renders a large cloud icon %>
    #
    # <%= mtl_icon :alert, class: 'right red' # add custom classes %>
    # ```
    module IconHelper
      ICON_CLASS = 'material-icons'.freeze

      def mtl_icon(icon, options = {})
        options[:class] = [ICON_CLASS, options.delete(:size), options[:class]].compact
        content_tag :i, icon, options
      end
    end
  end
end
