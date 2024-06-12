# frozen_string_literal: true

resources :products, param: :slug, only: %i[index show]

resources :products, param: :uuid, only: [] do
  resources :variants, except: [], param: :variant_uuid, module: :products do
    member do
      get :info
      post :add_to_cart
      post :guest_add_to_cart
      post :buy_now
      post :guest_buy_now
    end
  end
end
