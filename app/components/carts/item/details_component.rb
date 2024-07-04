# frozen_string_literal: true
# typed: true

class Carts::Item::DetailsComponent < ViewComponent::Base
  extend T::Sig

  delegate :checkbox_invalid?, :cannot?, :can?, to: :helpers
  attr_reader :cart

  sig { params(cart: Cart).void }
  def initialize(cart:)
    @cart = cart
    super
  end
end
