# frozen_string_literal: true

## only show admin routes if user is authenticated and is admin
authenticated :user, -> { _1.admin } do
  namespace :admin do
    root 'home#index'
    resources :products do
      collection do
        resources :categories
      end
      member do
        resources :variants, path: 'variants', param: :vid, only: [] do
          collection do
            get :index, to: 'variants#product_variants', as: 'product'
            get 'new', to: 'variants#product_variant_new', as: 'product_new'
            post 'create', to: 'variants#product_variant_create', as: 'product_create'
          end
          member do
            put 'update', to: 'variants#product_variant_update', as: 'product_update'
            delete 'delete', to: 'variants#product_variant_delete', as: 'product_delete'
            patch 'position', to: 'variants#product_variant_position', as: 'product_position'
          end
        end
        resources :images, only: [] do
          collection do
            get :index, to: 'images#product_images', as: 'product'
          end
        end
        resources :stocks, only: [] do
          collection do
            get :index, to: 'stocks#product_stocks', as: 'product'
          end
        end
      end
    end
  end
end
