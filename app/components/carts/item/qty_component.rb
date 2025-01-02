# frozen_string_literal: true
# typed: true

class Carts::Item::QtyComponent < ViewComponent::Base
  extend T::Sig

  delegate :cannot?, :quantity_invalid?, to: :helpers
  attr_reader :cart, :count_on_hand, :sale

  sig { params(cart: Cart, count_on_hand: Integer, sale: T::Boolean).void }
  def initialize(cart:, count_on_hand:, sale:)
    @cart = cart
    @sale = sale
    @count_on_hand = count_on_hand
    super
  end
end
