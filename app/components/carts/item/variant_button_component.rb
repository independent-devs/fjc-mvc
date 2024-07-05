# frozen_string_literal: true
# typed: true

class Carts::Item::VariantButtonComponent < ViewComponent::Base
  extend T::Sig

  delegate :cannot?, to: :helpers

  sig { params(cart: Cart, variant_pair: String, count_on_hand: Integer).void }
  def initialize(cart:, variant_pair:, count_on_hand:)
    @variant_pair = variant_pair
    @count_on_hand = count_on_hand
    @cart = cart
    super
  end
end
