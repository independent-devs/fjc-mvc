Rails.application.routes.draw do
  root "home#index"
  devise_for :users

  resources :products

  namespace :admin, path: '/admin' do
    root 'home#index'
    resources :products
  end
end
