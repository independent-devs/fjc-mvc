# frozen_string_literal: true
# typed: true

class Carts::Item::CartStockWarningComponent < ViewComponent::Base
  extend T::Sig

  delegate :quantity_invalid?, to: :helpers
  attr_reader :cart, :count_on_hand, :qty, :backorderable

  sig { params(cart: Cart, count_on_hand: Integer, backorderable: T::Boolean).void }
  def initialize(cart:, count_on_hand:, backorderable:)
    @count_on_hand = count_on_hand
    @backorderable = backorderable
    @cart = cart
    super
  end
end
