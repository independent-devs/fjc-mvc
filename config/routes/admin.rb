# frozen_string_literal: true

## only show admin routes if user is authenticated and is admin
authenticated :user, -> { _1.admin? } do
  namespace :admin do
    get '/', to: redirect('/admin/dashboard')
    resources :dashboard, only: [:index]

    ## product routes
    resources :products do
      resources :variants, only: %i[index new create update destroy], module: :products do
        member do
          patch :position
        end
      end
      resources :stocks, only: %i[index update], module: :products do
        member do
          put :modify
        end
      end
      resources :images, only: %i[index create update destroy], module: :products do
        collection do
          post :upload
        end
      end
      collection do
        resources :categories
      end
    end
  end
end
