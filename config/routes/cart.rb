# frozen_string_literal: true

resources :carts, param: :uuid, only: %i[index] do
  member do
    post :add_to_cart, as: :add_to
    post :guest_add_to_cart, as: :guest_add_to
    post :sync_cart, as: :sync
    put :item_update
    put :guest_item_update
  end
end
