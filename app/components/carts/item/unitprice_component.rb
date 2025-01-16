# frozen_string_literal: true
# typed: true

class Carts::Item::UnitpriceComponent < ViewComponent::Base
  extend T::Sig

  sig { params(cart: Cart, price: T.any(Integer, Float, BigDecimal), currency: String, discount: Integer).void }
  def initialize(cart:, price:, currency:, discount: 0)
    @cart = cart
    @price = price
    @currency = currency
    @discount = discount
    super
  end
end
