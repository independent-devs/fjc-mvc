# frozen_string_literal: true
# typed: true

class Carts::Item::BaseComponent < ViewComponent::Base
  extend T::Sig
  attr_reader :cart

  delegate :sale?, to: :helpers

  sig { params(cart: Cart).void }
  def initialize(cart:)
    @cart = cart
    super
  end
end
