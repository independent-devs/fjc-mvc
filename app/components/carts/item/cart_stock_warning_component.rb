# frozen_string_literal: true
# typed: true

class Carts::Item::CartStockWarningComponent < ViewComponent::Base
  extend T::Sig
  attr_reader :cart, :count_on_hand, :qty, :sale

  delegate :quantity_invalid?, to: :helpers

  sig { params(cart: Cart, count_on_hand: Integer, sale: T::Boolean).void }
  def initialize(cart:, count_on_hand:, sale:)
    @count_on_hand = count_on_hand
    @sale = sale
    @cart = cart
    super
  end
end
