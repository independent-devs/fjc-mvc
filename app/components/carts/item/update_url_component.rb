# frozen_string_literal: true
# typed: true

class Carts::Item::UpdateUrlComponent < ViewComponent::Base
  extend T::Sig

  delegate :can?, to: :helpers

  sig { params(cart: Cart).void }
  def initialize(cart:)
    @cart = cart
    super
  end
end
