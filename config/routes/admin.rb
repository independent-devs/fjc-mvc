# frozen_string_literal: true

## only show admin routes if user is authenticated and is admin
authenticated :user, -> { _1.admin? } do
  namespace :admin do
    get '/', to: redirect('/admin/dashboard')
    resources :dashboard, only: [:index]

    ## product routes
    resources :products do
      resources :variants, module: :products do
        member do
          patch 'position', to: 'variants#position'
        end
      end
      resources :stocks, only: %i[index update], module: :products do
        member do
          put 'modify', to: 'stocks#modify'
        end
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
      end
    end
  end
end
