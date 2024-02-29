Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  root "home#index"
  resources :products

  ## only show admin routes if user is authenticated and is admin
  authenticated :user, -> { _1.admin } do
    namespace :admin, path: '/admin' do
      root 'home#index'
      resources :products
    end
  end
end
