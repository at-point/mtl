module Materializer
  module Rails
    # Navbar / Header Helper
    # ======================
    #
    # Provides a helper to render a nice navbar, that is supposed to work on both
    # mobile as well as desktops. It is meant to be used with the mtl-default-layout
    # as defined by Marco.
    #
    # Include the following in every template that requires a navbar:
    #
    # ```erb
    #   <%= materializer_header t('my.title') %>
    # ```
    #
    # To render with a custom additional header content, this is then simply
    # appended after the title in the layout.
    #
    # ```erb
    #   <%= materializer_header 'Dashboard' do %>
    #     <ul class="right">
    #       <li>Current User: Hans</li>
    #       <li><%= link_to 'Logout', logout_path %></li>
    #     </ul>
    #   <%- end %>
    #
    # This renders the appropriate HTML snippet, see #materialize_header for
    # more options.
    module HeaderHelper
      # Renders a specialized template for the header.
      #
      # - **title** - `String` with the header to display, when set to `false`
      #   or an empty string, the rendering of the `<h1>` tag is skipped. By default
      #   it tries to use a translation via `.title` key
      # - **back:** - `String` (URL) with a link to return to the previous view,
      #   when this string is present, then the menu is skipped and this link
      #   is always present
      # - **menu:** - `String` (HTML ID) references the id of the aside menu / default
      #   nav menu to show / hide on mobile devices. The default used is `nav-menu`.
      #   When set to `false`, this button is skipped.
      # - **&block** - Additional content to be rendered as part of the header
      def materializer_header(title = translate('.title', default: 'Menu'),
                              back: false, menu: 'nav-menu', &block)
        materializer_content = block_given? ? capture(&block) : nil

        render file: 'materializer/header', locals: {
          materializer_content: materializer_content,
          materializer_title: title.presence,
          materializer_back: back,
          materializer_menu: menu
        }
      end
    end
  end
end
