# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def price_with_currency(price, unit = nil)
    number_to_currency(price, precision: 2, strip_insignificant_zeros: true, unit:)
  end

  def total_price_calc(price:, qty: 1)
    price * qty
  end
end
