# frozen_string_literal: true
# typed: true

class Carts::Item::DetailsComponent < ViewComponent::Base
  extend T::Sig
  attr_reader :cart, :sale

  delegate :cannot?, :can?, to: :helpers

  sig { params(cart: Cart, sale: T::Boolean).void }
  def initialize(cart:, sale:)
    @cart = cart
    @sale = sale
    super
  end
end
