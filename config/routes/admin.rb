# frozen_string_literal: true

## only show admin routes if user is authenticated and is admin
authenticated :user, -> { _1.admin? } do
  namespace :admin do
    get '/', to: redirect('/admin/dashboard')
    resources :dashboard, only: [:index]

    ## product routes
    resources :products do
      resources :variants, module: :products do
        patch 'position', to: 'variants#position'
      end

      collection do
        resources :categories
      end
      member do
        resources :images, param: :mid, only: [] do
          collection do
            get :index, to: 'images#product_images', as: 'product'
          end
          member do
            put 'position', to: 'images#product_image_position', as: 'product_position'
          end
        end
        resources :stocks, param: :vid, only: [] do
          collection do
            get :index, to: 'stocks#product_stocks', as: 'product'
          end
          member do
            put 'update', to: 'stocks#product_stock_update', as: 'product_update'
            put 'modify_stock', to: 'stocks#product_stock_modify', as: 'product_modify'
          end
        end
      end
    end
  end
end
