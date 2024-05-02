# frozen_string_literal: true

resources :products, param: :slug, only: %i[index show]
