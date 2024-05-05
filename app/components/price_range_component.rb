# frozen_string_literal: true

class PriceRangeComponent < ViewComponent::Base
  attr_reader :lowest, :highest, :currency

  def initialize(lowest:, highest:, currency: 'PHP')
    @lowest = lowest
    @highest = highest
    @currency = currency
    super
  end
end
