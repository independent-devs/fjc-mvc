# frozen_string_literal: true

class SectionComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
    super
  end
end
