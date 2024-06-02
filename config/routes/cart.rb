# frozen_string_literal: true

resources :carts, param: :uuid, only: %i[index] do
  member do
    post :add_to_cart
    post :guest_add_to_cart
    put :item_update
    put :guest_item_update
  end
end
