# frozen_string_literal: true

class Carts::Item::UnitpriceComponent < ViewComponent::Base
  def initialize(uuid:, price:, currency:)
    @uuid = uuid
    @price = price
    @currency = currency
    super
  end
end
