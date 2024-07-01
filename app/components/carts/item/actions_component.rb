# frozen_string_literal: true
# typed: true

class Carts::Item::ActionsComponent < ViewComponent::Base
  extend T::Sig

  delegate :cannot?, to: :helpers

  sig { params(cart: Cart).void }
  def initialize(cart:)
    @cart = cart
    super
  end
end
