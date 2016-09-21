# :nodoc:
module SimpleForm
  # :nodoc:
  module Components
    # Support for `suffix:` option when using the simple_form gem. When using the
    # provided `simple_form.rb` initializer everything should be properly setup
    # to make use of this input component.
    #
    # ## Usage
    #
    # Render a field with the suffix _CHF_:
    #
    # ```erb
    #   <%= f.input :amount, suffix: 'CHF' %>
    # ```
    #
    # Pass in custom HTML options to the suffix div:
    #
    # ```erb
    #   <%= f.input :amount, suffix: 'CHF', suffix_html: 'red-text' %>
    # ```
    #
    module Suffix
      def suffix(_wrapper_options = nil)
        return unless suffix?

        @suffix_tag ||= begin
          additional_classes << 'has-suffix'
          template.content_tag :div, suffix_label, suffix_html_options
        end
      end

      private

      def suffix?
        suffix_label
      end

      def suffix_label
        options[:suffix].presence
      end

      def suffix_html_options
        suffix_html = options.fetch(:suffix_html, {})
        suffix_html[:class] = [suffix_html[:class], 'suffix'].compact
        suffix_html
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Suffix)
