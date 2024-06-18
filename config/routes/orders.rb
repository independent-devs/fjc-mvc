# frozen_string_literal: true

resources :orders, param: :uuid, only: %i[] do
  collection do
    post :checkout
  end
end
