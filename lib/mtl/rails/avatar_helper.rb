module Mtl
  module Rails
    # Small helper to render avatars material style, containing the initials of the given person
    #
    # ### Avatar link
    #
    # A simple avatar link, without a picture
    #
    # ```erb
    # <%= mtl_avatar_link '/profile', 'John Doe' %>
    # ```
    #
    # An avatar link, with a custom user picture
    #
    # ```erb
    # <%= mtl_avatar_link '/profile', 'John Doe', '/john_doe.png' %>
    # ```
    #
    # An avatar link, with a custom user picture and some html options
    #
    # ```erb
    # <%= mtl_avatar_link '/profile', 'John Doe', '/john_doe.png', class: :red %>
    # ```
    #
    # ### Avatar
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
    # ### Avatar initials
    #
    # This helper generates the initials for the avatar, based on the person name.
    # It supports combined names or emails, and will return either a single initial, either a 2 letter.
    # Examples:
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
    module AvatarHelper
      # Renders an avatar link, for the given url with the name's initials
      #
      # @param url [String]
      # @param name [String]
      # @param image_url [String] Optional image url for the avatar
      # @param options [Hash] Additional options that can be passed to `link_to`
      def mtl_avatar_link(url, name, image_url = nil, options = {})
        options[:class] = ['avatar', options[:class]].compact
        link_to (image_url.present? ? image_tag(image_url, alt: name) : '') + mtl_avatar_initials(name), url, options
      end

      # Renders an avatar, for the given name, with initials and an optional picture
      #
      # @param name [String]
      # @param image_url [String] Optional image url for the avatar
      def mtl_avatar(name, image_url = '')
        content_tag :span, (image_url.present? ? image_tag(image_url, alt: name) : '') + mtl_avatar_initials(name), class: 'avatar'
      end

      # Creates initials based on the given name or email.
      #
      # @param name [String]
      def mtl_avatar_initials(name)
        initials = name.to_s.split('@').first.to_s.split(/[^[:alpha:]]+/).map(&:first)
        return initials.first.to_s.upcase if initials.length < 2
        [initials.first, initials.last].join.upcase
      end
    end
  end
end
