# frozen_string_literal: true
# typed: true

class Carts::Item::UnitpriceComponent < ViewComponent::Base
  extend T::Sig

  sig { params(cart: Cart, price: T.any(Integer, Float, BigDecimal), currency: String).void }
  def initialize(cart:, price:, currency:)
    @cart = cart
    @price = price
    @currency = currency
    super
  end
end
