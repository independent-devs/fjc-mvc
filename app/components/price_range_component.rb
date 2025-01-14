# frozen_string_literal: true
# typed: true

class PriceRangeComponent < ViewComponent::Base
  extend T::Sig

  delegate :price_with_currency, :discounted_price, to: :helpers
  attr_reader :lowest, :highest, :currency, :discount, :show_discount

  sig do
    params(
      lowest: T.any(Integer, Float, BigDecimal),
      highest: T.any(Integer, Float, BigDecimal, NilClass),
      currency: String,
      discount: Integer,
      show_discount: T::Boolean
    ).void
  end

  def initialize(lowest:, highest: nil, currency: 'PHP', discount: 0, show_discount: true)
    @lowest = lowest
    @highest = highest
    @currency = currency
    @discount = discount
    @show_discount = show_discount
    super
  end
end
