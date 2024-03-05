# frozen_string_literal: true

class PriceRangeComponent < ViewComponent::Base
  attr_reader :lowest, :highest

  def initialize(lowest:, highest:)
    @lowest = lowest
    @highest = highest
    super
  end
end
