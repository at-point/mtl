require 'uri'
require 'mtl/rails/card_file_presenter'
require 'mtl/rails/navbar_presenter'

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
    #
    # # Card file for files collection
    #
    # Basic usage:
    # ```erb
    # <%= mtl_card_file 'Document Dolorem.jpg', '/path/to/file.jpg' %>
    # ```
    # ```html
    # <a class="card-panel" href="/path/to/file.jpg" target="_blank" title="Document Dolorem.jpg">
    #   Document Dolorem.jpg
    #   <span class="grey-text">
    #     <i class="material-icons red-text">image</i>
    #     JPG
    #   </span>
    # </a>
    # ```
    #
    # With title option:
    # ```erb
    # <%= mtl_card_file 'Document Dolorem.jpg', '/path/to/file.jpg',
    #                                    title: 'foo' %>
    # ```
    # ```html
    # <a class="card-panel" href="/path/to/file.jpg" target="_blank" title="foo">
    #   <strong>foo</strong>
    #   Document Dolorem.jpg
    #   <span class="grey-text">
    #     <i class="material-icons red-text">image</i>
    #     JPG
    #   </span>
    # </a>
    # ```
    #
    # With type option:
    # ```erb
    # <%= mtl_card_file 'Document Dolorem.jpg', '/path/to/file.jpg',
    #                                    type: 'bar' %>
    # ```
    # ```html
    # <a class="card-panel" href="/path/to/file.jpg" target="_blank" title="Document Dolorem.jpg">
    #   Document Dolorem.jpg
    #   <span class="grey-text">
    #     <i class="material-icons blue-text">insert_drive_file</i>
    #     BAR
    #   </span>
    # </a>
    # ```
    #
    # With preview option:
    # ```erb
    # <%= mtl_card_file 'Document Dolorem.jpg', '/path/to/file.jpg',
    #                                    preview: '/path/to/preview.jpg' %>
    # ```
    # ```html
    # <a class="card-panel card-panel-image" href="/path/to/file.jpg" target="_blank"
    #    title="Document Dolorem.jpg" style="background-image: url(/path/to/preview.jpg)">
    #   Document Dolorem.jpg
    #   <span class="grey-text">
    #     <i class="material-icons red-text">image</i>
    #     JPG
    #   </span>
    # </a>
    # ```
    #
    # With delete option:
    # ```erb
    # <%= mtl_card_file 'Document Dolorem.jpg', '/path/to/file.jpg',
    #                                    delete: '/path/to/delete/the/file' %>
    # ```
    # ```html
    # <a class="card-panel" href="/path/to/file.jpg" target="_blank" title="Document Dolorem.jpg">
    #   Document Dolorem.jpg
    #   <span class="grey-text">
    #     <i class="material-icons red-text">image</i>
    #     JPG
    #   </span>
    #   <i class="close material-icons" data-mtl-href="/path/to/delete/the/file"
    #      data-method="delete">close</i>
    # </a>
    # ```
    #
    # With confirm option:
    # ```erb
    # <%= mtl_card_file 'Document Dolorem.jpg', '/path/to/file.jpg',
    #                                    delete: '/path/to/delete/the/file',
    #                                    confirm: 'Sure?' %>
    # ```
    # ```html
    # <a class="card-panel" href="/path/to/file.jpg" target="_blank" title="Document Dolorem.jpg">
    #   Document Dolorem.jpg
    #   <span class="grey-text">
    #     <i class="material-icons red-text">image</i>
    #     JPG
    #   </span>
    #   <i class="close material-icons" data-mtl-href="/path/to/delete/the/file"
    #     data-method="delete" data-confirm="Sure?">close</i>
    # </a>
    # ```
    #
    # # Navbars
    #
    # Basic usage:
    #
    # ```haml
    # = mtl_navbar do
    #   Hello
    # ```
    #
    # Fixed navbar:
    # ```haml
    # = mtl_navbar fixed: true do
    #   Hello
    # ```
    #
    # Extended navbar:
    # ```haml
    # = mtl_navbar do |nav|
    #   Hello
    #   = nav.extended do
    #     Hellobis
    # ```
    #
    # Extended and fixed navbar:
    # ```haml
    # = mtl_navbar fixed: true do |nav|
    #   Hello
    #   = nav.extended do
    #     Hellobis
    # ```
    module ViewHelpers
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
      # @yield Additional content to be rendered as part of the header, with a navbar object as argument,
      #        to also build the extended navigation if needed (by passing another block to nav.extended)
      # @return [String] HTML safe string
      def mtl_header(title = translate('.title', default: 'Menu'), **options, &block)
        mtl_class = ['mtl-layout-default-header', options[:class]].compact.flatten.join(' ')

        render file: 'mtl/header', locals: {
          mtl_content: block,
          mtl_title: title.presence,
          mtl_back: options.fetch(:back, false),
          mtl_menu: options.fetch(:menu, 'nav-menu'),
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
        options[:class] = [Mtl.icon_class, options.delete(:size), options[:class]].compact
        content_tag :i, icon, options
      end

      # Renders a card file tag to display the file and its informations, containing
      # icons, file name, link and an optional preview
      #
      # @param filename [String] filename of the file
      # @param href [String] url to pass to the link_to
      # @option options [String] :title Title of the link, defaults to the filename
      # @option options [String] :type To specify a custom file type, which will serve
      #         to display the icon. Will default to the file type based on the ext
      # @option options [String] :preview URL to an image to use as the file preview
      # @option options [String] :data-mtl-delete URL to use as the delete action, if any
      # @param options [Hash] additional options passed to `content_tag`
      # @return [String] HTML safe String
      def mtl_card_file(filename, href, options = {})
        CardFilePresenter.new(self).render(filename, href, options)
      end

      # Renders a navbar, wrapping the given block as content. Options also allows to fix the navbar and/or include
      # an extended navigation
      #
      # @option options [Boolean] :fixed Define if the header has to be fixed or not
      # @option options [String/Array] :class Additional class to add the to nav-wrapper
      # @yield Content to be rendered into the navbar, with a navbar object as argument, to also build the
      #        extended navigation if needed (by passing another block to nav.extended)
      # @option yield.extended options [String/Array] :class Additional class to add the to nav-extended
      # @return [String] HTML safe String
      def mtl_navbar(options = {}, &block)
        NavbarPresenter.new(self).render(options, &block)
      end
    end
  end
end
