# frozen_string_literal: true

## only show admin routes if user is authenticated and is admin
authenticated :user, -> { _1.admin } do
  namespace :admin do
    root 'home#index'
    resources :products do
      collection do
        resources :variants, path: '/:id/variants', only: [] do
          collection do
            get '/', to: 'variants#product', as: 'product'
          end
        end
        resources :images, path: '/:id/images', only: [] do
          collection do
            get '/', to: 'images#product', as: 'product'
          end
        end
        get '/:id/stocks', to: 'products#stocks', as: 'stocks'
        resources :categories
      end
    end
  end
end
