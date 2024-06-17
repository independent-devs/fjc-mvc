# frozen_string_literal: true

resources :carts, param: :uuid, only: %i[index update destroy] do
  member do
    post :sync
    post :sync_all
  end
end
