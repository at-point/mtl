require 'uri'

module Mtl
  module Rails
    # Private
    # Specialised renderer for the file card element used in a file collection
    class CardFilePresenter
      attr_reader :view

      def initialize(view)
        @view = view
      end

      def render(filename, href, params = {})
        params = params.reverse_merge type: File.extname(filename).delete('.')
        params[:href] = href
        card_params = { title: params[:title] || filename,
                        class: ['card-panel', params[:preview] ? 'card-panel-image' : nil],
                        data: data(filename, params),
                        style: if params[:preview]
                                 "background-image: url(#{URI.encode(params[:preview])})"
                               end }
        if params[:modal]
          view.content_tag :div, render_body(filename, params), card_params
        else
          view.link_to render_body(filename, params), href, card_params.merge(target: '_blank')
        end
      end

      def render_body(filename, params)
        view.safe_join [label(filename, params[:title]), infos(params), delete(params), download(filename, params)]
      end

      private

      def label(filename, title = nil)
        return filename_tag(filename) unless title
        view.safe_join [view.content_tag(:strong, title, class: 'truncate'), filename_tag(filename)]
      end

      def filename_tag(filename)
        view.content_tag(:span, filename, class: 'truncate')
      end

      def infos(params)
        view.content_tag :span, icon(params[:type]) + " #{params[:type].upcase}", class: 'secondary'
      end

      def icon(type)
        icon, icon_class = Mtl.file_icons[type.to_s.downcase] ||
                           Mtl.file_icons['other'] ||
                           [:insert_drive_file, 'blue-text']
        view.mtl_icon(icon, class: icon_class)
      end

      def delete(params)
        return unless params[:delete]
        data = { method: :delete, 'mtl-href': params[:delete], confirm: params[:confirm] }
        view.mtl_icon :close, class: 'close', data: data.reject { |_, v| v.blank? }
      end

      def download(filename, params)
        return unless params[:modal]
        view.link_to view.mtl_icon(:file_download), params[:href], title: params[:title] || filename,
                                                                   target: '_blank',
                                                                   class: 'download-link',
                                                                   download: params[:title] || filename
      end

      def data(filename, params)
        data = params[:data] || {}
        data.merge(modal_data(filename, params))
      end

      def modal_data(filename, params)
        return {} unless params[:modal]
        { mtl_document_modal: 'open', mtl_document_name: filename, href: params[:href] }
      end
    end
  end
end
