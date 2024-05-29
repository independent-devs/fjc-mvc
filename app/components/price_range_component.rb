# frozen_string_literal: true

class PriceRangeComponent < ViewComponent::Base
  delegate :price_with_currency, to: :helpers
  attr_reader :lowest, :highest, :currency

  def initialize(lowest:, highest: nil, currency: 'PHP')
    @lowest = lowest
    @highest = highest
    @currency = currency
    super
  end
end
