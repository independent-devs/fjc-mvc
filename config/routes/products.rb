# frozen_string_literal: true

resources :products, param: :slug, only: %i[index show]

post 'products/buy_now/:pid/:vid', to: 'products#buy_now', as: "buy_now"
get 'products/variant_info/:pid/:vid', to: 'products#variant_info', as: "variant_info", defaults: { format: 'turbo_stream' }
