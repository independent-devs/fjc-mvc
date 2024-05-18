# frozen_string_literal: true

resources :carts, param: :uuid, only: %i[index] do
  member do
    post :add_to_cart
    post :guest_add_to_cart
  end
end
