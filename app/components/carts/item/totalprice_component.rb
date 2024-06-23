# frozen_string_literal: true

class Carts::Item::TotalpriceComponent < ViewComponent::Base
  delegate :total_price_calc, to: :helpers

  def initialize(uuid:, price:, currency:, qty:)
    @uuid = uuid
    @price = price
    @currency = currency
    @qty = qty
    super
  end
end
