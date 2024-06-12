# frozen_string_literal: true

resources :carts, param: :uuid, only: %i[index] do
  member do
    post :sync
    post :sync_all
    put :item_update
    put :guest_item_update
    delete :guest_destroy
  end
end
