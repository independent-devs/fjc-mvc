# frozen_string_literal: true

class Carts::Item::QtyComponent < ViewComponent::Base
  delegate :cannot?, to: :helpers

  def initialize(cart:)
    @cart = cart
    super
  end
end
