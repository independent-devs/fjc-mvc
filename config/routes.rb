Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  root "home#index"
  resources :products

  namespace :admin, path: '/admin' do
    root 'home#index'
    resources :products
  end
end
