# frozen_string_literal: true

## only show admin routes if user is authenticated and is admin
authenticated :user, -> { _1.admin } do
  namespace :admin do
    root 'home#index'
    resources :products do
      collection do
        get '/:id/variants', to: 'products#variants', as: 'variants'
        get '/:id/images', to: 'products#images', as: 'images'
        get '/:id/stocks', to: 'products#stocks', as: 'stocks'
      end
    end
    resources :categories
  end
end
