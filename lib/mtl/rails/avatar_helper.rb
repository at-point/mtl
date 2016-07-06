module Mtl
  module Rails
    # Avatar Helper
    # ===========
    #
    # Small helper to render avatars material style.
    #
    # **Examples**
    # ```erb
    # <%= mtl_avatar 'LG' # renders a text avatar with 'LG' %>
    # <%= mtl_avatar 'LG', '/path_to_image' # renders an image avatar, with 'LG' as fallback %>
    # ```
    module AvatarHelper
      def mtl_avatar(initials, image = '')
        content_tag :div, (image.present? ? image_tag(image) : '') + initials , class: 'avatar'
      end
    end
  end
end
