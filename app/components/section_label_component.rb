# frozen_string_literal: true

class SectionLabelComponent < ViewComponent::Base
  attr_reader :label

  def initialize(label:)
    @label = label
    super
  end
end
