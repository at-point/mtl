module Mtl
  module Rails
    # Helper methods to create flat, raised and floating material UI buttons.
    #
    # ### Flat button
    #
    # A simple flat button:
    #
    # ```erb
    # <%= mtl_button_flat 'Cancel', users_path %>
    # ```
    #
    # A colored flat button:
    #
    # ```erb
    # <%= mtl_button_flat 'Delete', user_path(@user), class: 'red-text', method: :delete %>
    # ```
    #
    # ### Raised button
    #
    # A default raised action button:
    #
    # ```erb
    # <%= mtl_button "Next", next_user_path %>
    # ```
    #
    # A raised button with a sprinkle of colour:
    #
    # ```erb
    # <%= mtl_button "Ok", ok_path, class: 'green darken-2'
    # ```
    #
    # ### Floating button
    #
    # A round red, large floating button:
    #
    # ```erb
    # <%= mtl_button_floating :add, new_user_path, class: 'btn-large red'
    # ```
    #
    # @see http://materializecss.com/buttons.html MaterializeCSS: Buttons
    # @see https://material.google.com/components/buttons.html
    #      Google: Buttons
    # @see https://material.google.com/components/buttons-floating-action-button.html
    #      Google: Floating Action Buttons
    module ButtonHelper
      # Renders a flat button which does not visually lift like the raised buttons.
      #
      # @param label [String]
      # @param url [String]
      # @param options [Hash] Additional options that can be passed to `link_to`
      def mtl_button_flat(label, url, options = {})
        options[:class] = ['btn-flat', options[:class]].compact
        mtl_button label, url, options
      end

      # Renders a round floating button, with an icon as it's label.
      #
      # @param icon [Symbol]
      # @param url [String]
      # @param options [Hash] Additional options passed to `link_to`
      def mtl_button_floating(icon, url, options = {})
        options[:class] = ['btn-floating', options[:class]].compact
        mtl_button mtl_icon(icon), url, options
      end

      # Renders a visually raised button, i.e. the default button style.
      #
      # @param label [String]
      # @param url [String]
      # @param options [Hash] Additional options passed to `link_to`
      def mtl_button(label, url, options = {})
        options[:class] = ['btn', Mtl.effects, options[:class]].compact
        link_to label, url, options
      end
    end
  end
end
