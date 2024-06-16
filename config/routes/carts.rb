# frozen_string_literal: true

resources :carts, param: :uuid, only: %i[index update destroy] do
  member do
    post :sync
    post :sync_all
    put :guest_update
    delete :guest_destroy
  end
end
