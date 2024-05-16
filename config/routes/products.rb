# frozen_string_literal: true

resources :products, param: :slug, only: %i[index show]

post 'add_to_cart/:pid/:vid', to: 'products#add_to_cart', as: "add_to_cart"
post 'buy_now/:pid/:vid', to: 'products#buy_now', as: "buy_now"
get 'variant_info/:pid/:vid', to: 'products#variant_info', as: "variant_info", defaults: { format: 'turbo_stream' }
