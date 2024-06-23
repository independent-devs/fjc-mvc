# frozen_string_literal: true

class Carts::Item::DetailsComponent < ViewComponent::Base
  delegate :can?, to: :helpers
  attr_reader :cart

  def initialize(cart:)
    @cart = cart
    super
  end
end
