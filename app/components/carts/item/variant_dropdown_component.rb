# frozen_string_literal: true
# typed: true

class Carts::Item::VariantDropdownComponent < ViewComponent::Base
  extend T::Sig

  sig { params(cart: Cart, sale: T::Boolean).void }
  def initialize(cart:, sale:)
    @cart = cart
    @sale = sale
    super
  end
end
