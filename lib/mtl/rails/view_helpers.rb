module Mtl
  module Rails
    # Assortment of Rails view helpers to simplify rendering materialize css
    # specific components like:
    #
    # - [Icons](#label-Icons),
    # - [Avatars](#label-Avatars),
    # - [Nav Toolbars / Headers](#label-Navbars+-2F+Headers)
    # - or [Buttons](#label-Buttons)
    #
    # ## Buttons
    #
    # Helper methods to create flat, raised and floating material UI buttons.
    #
    # ## Flat buttons
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
    # ## Raised button
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
    # ## Floating button
    #
    # A round red, large floating button:
    #
    # ```erb
    # <%= mtl_button_floating :add, new_user_path, class: 'btn-large red'
    # ```
    #
    # #### Reference
    #
    # - [Materialize CSS: Buttons](http://materializecss.com/buttons.html)
    # - [Google: Buttons](https://material.google.com/components/buttons.html)
    # - [Google: Floating Action Buttons](https://material.google.com/components/buttons-floating-action-button.html)
    #
    # # Navbars / Headers
    #
    # Provides a helper to render a nice navbar, that is supposed to work on both
    # mobile as well as desktops. It is meant to be used with the mtl-default-layout
    # as defined by Marco.
    #
    # Include the following in every template that requires a navbar:
    #
    # ```
    # <%= mtl_header t('my.title') %>
    # ```
    #
    # To render with a custom additional header content, this is then simply
    # appended after the title in the layout.
    #
    # ```erb
    # <%= mtl_header 'Dashboard' do %>
    #   <ul class="right">
    #     <li>Current User: Hans</li>
    #     <li><%= link_to 'Logout', logout_path %></li>
    #   </ul>
    # <%- end %>
    # ```
    #
    # This renders the appropriate HTML snippet, see #materialize_header for
    # more options.
    #
    # #### Reference
    #
    # - [Materialize CSS: Navbar](http://materializecss.com/navbar.html)
    #
    # ## Avatars
    #
    # A simple avatar link, without a picture
    #
    # ```erb
    # <%= mtl_avatar_link '/profile', 'John Doe' %>
    # ```
    #
    # Render a large avatar link, with a custom user picture:
    #
    # ```erb
    # <%= mtl_avatar_link '/profile', 'John Doe', '/john_doe.png', size: :large %>
    # ```
    #
    # An avatar link, with a custom user picture and some html options
    #
    # ```erb
    # <%= mtl_avatar_link '/profile', 'John Doe', '/john_doe.png', class: :red %>
    # ```
    #
    # ### Unlinked avatars
    #
    # A simple avatar, without a picture
    #
    # ```erb
    # <%= mtl_avatar 'John Doe' %>
    # ```
    #
    # An avatar, with a picture
    #
    # ```erb
    # <%= mtl_avatar 'John Doe', '/john_doe.png' %>
    # ```
    #
    # An avatar, with a picture and some html options
    #
    # ```erb
    # <%= mtl_avatar 'John Doe', '/john_doe.png', class: :red %>
    # ```
    #
    # ### Avatar initials
    #
    # This helper generates the initials for the avatar, based on the person name. It supports
    # combined names or emails, and will return either a single initial, either a 2 letter.
    #
    # **Examples:**
    #
    # - John Doe -> JD
    # - John Von Doe -> JD
    # - John Albert Von Doe -> JD
    # - john@doe.com -> J
    # - john.doe@doe.com -> JD
    # - john-albert.von-doe@doe.com -> JD
    #
    # ```erb
    # <%= mtl_avatar_initials 'John Doe' %>
    # ```
    #
    # # Icons
    #
    # Renders using using Google Material Icon font:
    #
    # ```erb
    # <%= mtl_icon :cloud # renders a "cloud" icon %>
    # <%= mtl_icon :cloud, size: :large # renders a large cloud icon %>
    #
    # <%= mtl_icon :alert, class: 'right red' # add custom classes %>
    # ```
    #
    # #### Reference
    #
    # - [List of available icons](https://design.google.com/icons/)
    # - [Materialize CSS: Icons](http://materializecss.com/icons.html)
    #
    module ViewHelpers
      # @!visibility private
      ICON_CLASS = 'material-icons'.freeze

      # Renders a flat button which does not visually lift like the raised buttons.
      #
      # @param label [String]
      # @param url [String]
      # @param options [Hash] Additional options that can be passed to `link_to`
      # @return [String] HTML safe `<a/>` tag
      def mtl_button_flat(label, url, options = {})
        options[:class] = ['btn-flat', options[:class]].compact
        mtl_button label, url, options
      end

      # Renders a round floating button, with an icon as it's label.
      #
      # @param icon [Symbol]
      # @param url [String]
      # @param options [Hash] Additional options passed to `link_to`
      # @return [String] HTML safe `<a/>` tag
      def mtl_button_floating(icon, url, options = {})
        options[:class] = ['btn-floating', options[:class]].compact
        mtl_button mtl_icon(icon), url, options
      end

      # Renders a flat button with the more_vert icon dots in a wrapper element.
      # This is intended to be used to render these "more buttons" on the right,
      # in cards or the navbar.
      #
      # ```erb
      # <%= mtl_button_more '#dropdown', 'data-mtl-dropdown': true %>
      # ```
      #
      # @param url [String] usually probably references the dropdown to trigger
      # @param options [Hash] Additional options passed to `link_to`
      # @return [String] HTML safe `<a/>` tag
      def mtl_button_more(url, options = {})
        wrapper_class = ['btn-more-wrapper', options.delete(:wrapper_class)].compact
        options[:class] = ['btn-more', options[:class]].compact.flatten

        btn = mtl_button_flat mtl_icon(:more_vert, size: :tiny), url, options
        content_tag :div, btn, class: wrapper_class
      end

      # Renders a visually raised button, i.e. the default button style.
      #
      # @param label [String]
      # @param url [String]
      # @param options [Hash] Additional options passed to `link_to`
      # @return [String] HTML safe `<a/>` tag
      def mtl_button(label, url, options = {})
        options[:class] = ['btn', Mtl.effects, options[:class]].compact
        link_to label, url, options
      end

      # Renders a specialized template for the header.
      #
      # @param title [String] with the header to display, when set to `false`
      #   or an empty string, the rendering of the `<h1>` tag is skipped. By default
      #   it tries to use a translation via `.title` key
      # @param back [String, Boolean] (URL) with a link to return to the previous view,
      #   when this string is present, then the menu is skipped and this link
      #   is always present
      # @param menu [String, Boolean] (HTML ID) references the id of the aside menu / default
      #   nav menu to show / hide on mobile devices. The default used is `nav-menu`.
      #   When set to `false`, this button is skipped.
      # @param class [String, Array] (HTML CLASS) additional, custom css class on header
      # @yield Additional content to be rendered as part of the header
      # @return [String] HTML safe string
      def mtl_header(title = translate('.title', default: 'Menu'), **options, &block)
        mtl_content = block_given? ? capture(&block) : nil
        mtl_class = ['mtl-layout-default-header', options[:class]].compact.flatten.join(' ')
        mtl_back = options.fetch(:back, false)
        mtl_menu = options.fetch(:menu, 'nav-menu')

        render file: 'mtl/header', locals: {
          mtl_content: mtl_content,
          mtl_title: title.presence,
          mtl_back: mtl_back,
          mtl_menu: mtl_menu,
          mtl_class: mtl_class
        }
      end

      # Renders an avatar link, for the given url with the name's initials
      #
      # @param url [String]
      # @param name [String]
      # @param image_url [String] Optional image url for the avatar
      # @option options [:small, :medium, :large] :size
      # @param options [Hash] Additional options that can be passed to `link_to`
      # @return [String] HTML safe `<a/>` tag
      def mtl_avatar_link(url, name, image_url = nil, options = {})
        options[:class] = [
          'mtl-avatar', Mtl.effects, options.delete(:size), options[:class]
        ].compact
        image = (image_url.present? ? image_tag(image_url, alt: name) : '')
        link_to image + mtl_avatar_initials(name), url, options
      end

      # Renders an avatar, for the given name, with initials and an optional picture
      #
      # @param name [String]
      # @param image_url [String] Optional image url for the avatar
      # @option options [:small, :medium, :large] :size
      # @param options [Hash] Additional options that can be passed to `link_to`
      # @return [String] HTML safe `<span/>` tag
      def mtl_avatar(name, image_url = nil, options = {})
        options[:class] = ['mtl-avatar', options.delete(:size), options[:class]].compact
        image = (image_url.present? ? image_tag(image_url, alt: name) : '')
        content_tag :span, image + mtl_avatar_initials(name), options
      end

      # Creates initials based on the given name or email.
      #
      # @param name [String]
      # @return [String]
      # @!visibility private
      def mtl_avatar_initials(name)
        initials = name.to_s.upcase.split('@').first.to_s.split(/[^[:alpha:]]+/).map(&:first)
        return initials.first.to_s if initials.length < 2
        [initials.first, initials.last].join
      end

      # Renders an `<i class="material-icons">icon</i>` tag to display an icon.
      #
      # @param icon [Symbol] name of the icon to render, note that these are
      #        usually underscored, like e.g. `:aspect_ratio`
      # @option options [:tiny, :small, :medium, :large] :size
      # @param options [Hash] additional options passed to `content_tag`
      # @return [String] HTML safe String
      def mtl_icon(icon, options = {})
        options[:class] = [ICON_CLASS, options.delete(:size), options[:class]].compact
        content_tag :i, icon, options
      end
    end
  end
end
