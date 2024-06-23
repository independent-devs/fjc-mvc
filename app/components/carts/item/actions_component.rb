# frozen_string_literal: true

class Carts::Item::ActionsComponent < ViewComponent::Base
  delegate :cannot?, to: :helpers

  def initialize(cart:)
    @cart = cart
    super
  end
end
