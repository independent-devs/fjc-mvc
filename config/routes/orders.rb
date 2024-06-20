# frozen_string_literal: true

resources :orders, param: :uuid, only: %i[show create] do
  member do
    delete :cancel
  end
end
