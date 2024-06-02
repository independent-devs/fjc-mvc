# frozen_string_literal: true

module CartsHelper
  def cart_item_update_url(cart)
    cart.user_id.present? ? item_update_cart_url(cart.uuid) : guest_item_update_cart_url(cart.uuid)
  end
end
