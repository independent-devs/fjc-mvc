# frozen_string_literal: true

class Carts::Item::Component < ViewComponent::Base
  attr_reader :cart

  def initialize(cart:)
    @cart = cart
    super
  end
end
