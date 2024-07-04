# frozen_string_literal: true
# typed: true

class Carts::Item::QtyComponent < ViewComponent::Base
  extend T::Sig

  delegate :cannot?, :quantity_invalid?, to: :helpers
  attr_reader :cart, :count_on_hand, :backorderable

  sig { params(cart: Cart, count_on_hand: Integer, backorderable: T::Boolean).void }
  def initialize(cart:, count_on_hand:, backorderable:)
    @cart = cart
    @backorderable = backorderable
    @count_on_hand = count_on_hand
    super
  end
end
