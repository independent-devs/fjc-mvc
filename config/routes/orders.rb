# frozen_string_literal: true

resources :orders, only: %i[show create] do
  member do
    delete :cancel
  end
end
