# frozen_string_literal: true
# typed: true

class Carts::Item::TotalpriceComponent < ViewComponent::Base
  extend T::Sig

  delegate :total_price_calc, to: :helpers

  sig do
    params(cart: Cart, price: T.any(Integer, Float, BigDecimal), currency: String).void
  end
  def initialize(cart:, price:, currency:)
    @cart = cart
    @price = price
    @currency = currency
    super
  end
end
