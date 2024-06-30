# frozen_string_literal: true
# typed: true

class Carts::Item::TotalpriceComponent < ViewComponent::Base
  extend T::Sig

  delegate :total_price_calc, to: :helpers

  sig { params(uuid: String, price: T.any(Integer, Float, BigDecimal), currency: String, qty: Integer).void }
  def initialize(uuid:, price:, currency:, qty:)
    @uuid = uuid
    @price = price
    @currency = currency
    @qty = qty
    super
  end
end
