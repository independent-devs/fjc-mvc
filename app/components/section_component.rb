# frozen_string_literal: true

class SectionComponent < ViewComponent::Base
  attr_reader :label, :title, :action_partial

  def initialize(label:, title:, action_partial: '')
    @label = label
    @title = title
    @action_partial = action_partial
    super
  end
end
