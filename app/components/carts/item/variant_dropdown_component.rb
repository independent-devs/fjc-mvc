# frozen_string_literal: true
# typed: true

class Carts::Item::VariantDropdownComponent < ViewComponent::Base
  extend T::Sig

  sig { params(cart: Cart).void }
  def initialize(cart:)
    @cart = cart
    super
  end
end
