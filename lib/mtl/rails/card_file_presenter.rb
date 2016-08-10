require 'uri'

module Mtl
  module Rails
    # Specialised renderer for the file card element used in a file collection
    #
    # Basic usage:
    # ```ruby
    # CardFilePresenter.new(view).render('Document Dolorem.jpg', '/path/to/file.jpg')
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
    # ```ruby
    # CardFilePresenter.new(view).render('Document Dolorem.jpg', '/path/to/file.jpg',
    #                                    title: 'foo')
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
    # ```ruby
    # CardFilePresenter.new(view).render('Document Dolorem.jpg', '/path/to/file.jpg',
    #                                    type: 'bar')
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
    # ```ruby
    # CardFilePresenter.new(view).render('Document Dolorem.jpg', '/path/to/file.jpg',
    #                                    preview: '/path/to/preview.jpg')
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
    # With data-mtl-delete option:
    # ```ruby
    # CardFilePresenter.new(view).render('Document Dolorem.jpg', '/path/to/file.jpg',
    #                                    'data-mtl-delete': '/path/to/delete/the/file')
    # ```
    # ```html
    # <a class="card-panel" href="/path/to/file.jpg" target="_blank" title="Document Dolorem.jpg">
    #   Document Dolorem.jpg
    #   <span class="grey-text">
    #     <i class="material-icons red-text">image</i>
    #     JPG
    #   </span>
    #   <a href="/path/to/delete/the/file" method="delete">
    #     <i class="close material-icons">close</i>
    #   </a>
    # </a>
    # ```
    class CardFilePresenter
      attr_reader :view

      def initialize(view)
        @view = view
      end

      def render(filename, href, params = {})
        params = params.reverse_merge type: File.extname(filename).delete('.')
        view.link_to render_body(filename, params), href,
                     title: params[:title] || filename,
                     target: '_blank',
                     class: ['card-panel', params[:preview] ? 'card-panel-image' : nil],
                     style: if params[:preview]
                              "background-image: url(#{URI.encode(params[:preview])})"
                            end
      end

      def render_body(filename, params)
        view.safe_join [label(filename, params[:title]), infos(params), delete(params)]
      end

      private

      def label(filename, title = nil)
        return filename unless title
        view.safe_join [view.content_tag(:strong, title), filename]
      end

      def infos(params)
        view.content_tag :span, icon(params[:type]) + " #{params[:type].upcase}", class: 'grey-text'
      end

      def icon(type)
        icon, icon_class = Mtl.file_icons[type.to_s.downcase] ||
                           Mtl.file_icons['other'] ||
                           [:insert_drive_file, 'blue-text']
        view.mtl_icon(icon, class: icon_class)
      end

      def delete(params)
        view.link_to(view.mtl_icon(:close, class: 'close'),
                     params['data-mtl-delete'],
                     method: :delete) if params['data-mtl-delete'].present?
      end
    end
  end
end
