# frozen_string_literal: true
# typed: true

class Carts::Item::Component < ViewComponent::Base
  extend T::Sig

  attr_reader :cart

  sig { params(cart: Cart).void }
  def initialize(cart:)
    @cart = cart
    super
  end
end
