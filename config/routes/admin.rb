# frozen_string_literal: true

## only show admin routes if user is authenticated and is admin
authenticated :user, -> { _1.admin } do
  namespace :admin do
    root 'home#index'
    resources :products
    resources :categories
  end
end
