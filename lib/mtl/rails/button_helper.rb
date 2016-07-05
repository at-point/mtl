module Mtl
  module Rails
    # Buttons
    # =======
    #
    # Helper methods to create both raised and flat buttons by wrapping the
    # original Rails `link_to` helper method.
    #
    # **Examples**
    # ```erb
    # <%= mtl_button "New", new_user_path # create a raised button %>
    # <%= mtl_button_flat "Delete", user_path(@user), method: :delete # create a flat button %>
    # <%= mtl_button_floating "+", user_path(@user), method: :delete # create a floating button %>
    # ```
    #
    module ButtonHelper
      def mtl_button_flat(text, url, options = {})
        options[:class] = ['btn-flat', options[:class]].compact
        mtl_button text, url, options
      end

      def mtl_button(text, url, options = {})
        options[:class] = ['btn', Mtl.effects, options[:class]].compact
        link_to text, url, options
      end

      def mtl_button_floating(text, url, options = {})
        options[:class] = ['btn-floating', options[:class]].compact
        mtl_button text, url, options
      end
    end
  end
end
