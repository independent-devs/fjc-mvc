# frozen_string_literal: true

class SectionComponent < ViewComponent::Base
  attr_reader :label, :title

  def initialize(label:, title:)
    @label = label
    @title = title
    super
  end
end
