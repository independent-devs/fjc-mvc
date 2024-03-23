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
            get '/new', to: 'variants#product_variant_new', as: 'product_new'
            post '/create', to: 'variants#product_variant_create', as: 'product_create'
            put '/:vid/update', to: 'variants#product_variant_update', as: 'product_update'
            delete '/:vid/delete', to: 'variants#product_variant_delete', as: 'product_delete'
            patch '/:vid/position', to: 'variants#update_position', as: 'product_position'
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
