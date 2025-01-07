# frozen_string_literal: true

root 'home#index'

resources :products, only: %i[index show]
resources :checkout, only: %i[show]

resources :carts, only: %i[index update destroy] do
  collection do
    get :total
    get :count
    post :sync_all
    delete :bulk_delete
  end
  member do
    get :variant_dropdown
    post :sync
  end
end

resources :variants, only: [] do
  member do
    get :info
    post :add_to_cart
    post :guest_add_to_cart
    post :buy_now
    post :guest_buy_now
  end
end

resource :account, only: :show
resources :orders, only: %i[index show] do
  member do
    delete :cancel
  end
end
