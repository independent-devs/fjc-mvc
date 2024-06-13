# frozen_string_literal: true

module CartsHelper
  def cart_item_update_url(cart)
    cart.user_id.present? ? cart_url(cart.uuid) : guest_update_cart_url(cart.uuid)
  end
end
