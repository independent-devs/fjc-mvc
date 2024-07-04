# frozen_string_literal: true
# typed: true

class Carts::Item::DetailsComponent < ViewComponent::Base
  extend T::Sig

  delegate :checkbok_invalid?, :cannot?, to: :helpers
  attr_reader :cart

  sig { params(cart: Cart).void }
  def initialize(cart:)
    @cart = cart
    super
  end
end
