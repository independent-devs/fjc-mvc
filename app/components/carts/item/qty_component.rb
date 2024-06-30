# frozen_string_literal: true
# typed: true

class Carts::Item::QtyComponent < ViewComponent::Base
  extend T::Sig

  delegate :cannot?, to: :helpers

  sig { params(cart: Cart).void }
  def initialize(cart:)
    @cart = cart
    super
  end
end
