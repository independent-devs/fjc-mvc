# frozen_string_literal: true

class Carts::Item::UpdateUrlComponent < ViewComponent::Base
  def initialize(cart:)
    @cart = cart
    super
  end
end
