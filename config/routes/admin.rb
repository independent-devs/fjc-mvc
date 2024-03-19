# frozen_string_literal: true

## only show admin routes if user is authenticated and is admin
authenticated :user, -> { _1.admin } do
  namespace :admin do
    root 'home#index'
    resources :products do
      collection do
        resources :variants, path: '/:id/variants', only: [] do
          collection do
            get '/', to: 'variants#product_variants', as: 'product'
            post '/', to: 'variants#product_variant_create', as: 'product_create'
            get '/new', to: 'variants#product_variant_new', as: 'product_new'
            put '/:vid/update', to: 'variants#product_variant_update', as: 'product_update'
            patch '/:vid/update_position', to: 'variants#update_position', as: 'product_update_position'
          end
        end
        resources :images, path: '/:id/images', only: [] do
          collection do
            get '/', to: 'images#product_images', as: 'product'
          end
        end
        get '/:id/stocks', to: 'products#stocks', as: 'stocks'
        resources :categories
      end
    end
  end
end
