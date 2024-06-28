# frozen_string_literal: true
# typed: true

module ApplicationHelper
  extend T::Sig
  include Pagy::Frontend

  sig { params(price: T.any(Integer, Float, BigDecimal), unit: String).returns(String) }
  def price_with_currency(price, unit = '')
    T.must(ActionController::Base
      .helpers
      .number_to_currency(
        price,
        precision: 2,
        strip_insignificant_zeros: true,
        unit:
      ))
  end

  sig do
    params(price: T.any(Integer, Float, BigDecimal), qty: Integer)
      .returns(T.any(Integer, Float, BigDecimal))
  end
  def total_price_calc(price:, qty: 1)
    price * qty
  end
end
