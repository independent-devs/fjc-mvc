# frozen_string_literal: true
# typed: true

class PriceRangeComponent < ViewComponent::Base
  extend T::Sig

  delegate :price_with_currency, to: :helpers
  attr_reader :lowest, :highest, :currency

  sig do
    params(
      lowest: T.any(Integer, Float, BigDecimal),
      highest: T.any(Integer, Float, BigDecimal, NilClass),
      currency: String
    ).void
  end
  def initialize(lowest:, highest: nil, currency: 'PHP')
    @lowest = lowest
    @highest = highest
    @currency = currency
    super
  end
end
