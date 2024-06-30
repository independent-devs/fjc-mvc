# frozen_string_literal: true
# typed: true

class Carts::Item::UnitpriceComponent < ViewComponent::Base
  extend T::Sig

  sig { params(uuid: String, price: T.any(Integer, Float, BigDecimal), currency: String).void }
  def initialize(uuid:, price:, currency:)
    @uuid = uuid
    @price = price
    @currency = currency
    super
  end
end
