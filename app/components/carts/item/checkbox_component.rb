# frozen_string_literal: true
# typed: true

class Carts::Item::CheckboxComponent < ViewComponent::Base
  extend T::Sig

  sig { params(cart: Cart, invalid: T::Boolean, checked: T::Boolean).void }
  def initialize(cart:, invalid: false, checked: false)
    @cart = cart
    @invalid = invalid
    @checked = checked
    super
  end
end
