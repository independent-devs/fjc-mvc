# frozen_string_literal: true

resources :account, only: :index do
  collection do
    resources :orders, only: :index
  end
end
