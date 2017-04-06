require 'simple_form'

# :nodoc:
module SimpleForm
  # :nodoc:
  module Inputs
    # :nodoc:
    class SwitchInput < ::SimpleForm::Inputs::BooleanInput
      def input(_wrapper_options = nil)
        template.content_tag(:div, class: :switch) do
          build_hidden_field_for_checkbox +
            template.label_tag(nil) do
              build_check_box_without_hidden_field(input_html_options) +
                template.content_tag(:span, nil, class: :lever) +
                label_text
            end
        end
      end

      def label_input(wrapper_options = nil)
        input(wrapper_options)
      end

      def label(_wrapper_options = nil)
        ''
      end
    end
  end
end
