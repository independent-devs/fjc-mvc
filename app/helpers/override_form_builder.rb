# frozen_string_literal: true

class OverrideFormBuilder < ActionView::Helpers::FormBuilder
  def rich_text_area(method, options = {})
    @template.content_tag(:div, class: 'bg-white p-2 border border-gray-400 rounded-sm min-h-60') do
      super
    end
  end
end
