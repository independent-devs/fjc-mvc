# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    user { User.last || create(:user) }
    guest_session { GuestSession.last || create(:guest_session) }
    variant { create(:variant) }
    qty { Faker::Number.non_zero_digit }
    order { Order.last || create(:order) }

    trait :guest_cart do
      order { nil }
      user { nil }
    end

    trait :user_cart do
      guest_session { nil }
      order { nil }
    end

    trait :user_cart_synced do
      order { nil }
    end

    trait :guest_session_order do
      user { nil }
    end

    trait :user_order do
      guest_session { nil }
    end

    trait :not_owned do
      user { nil }
      guest_session { nil }
    end
  end
end

# == Schema Information
#
# Table name: carts
#
#  id               :bigint           not null, primary key
#  qty              :integer          default(1), not null
#  uuid             :uuid             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  guest_session_id :bigint
#  order_id         :bigint
#  user_id          :bigint
#  variant_id       :bigint           not null
#
# Indexes
#
#  index_carts_on_guest_session_id  (guest_session_id)
#  index_carts_on_order_id          (order_id)
#  index_carts_on_user_id           (user_id)
#  index_carts_on_uuid              (uuid) UNIQUE
#  index_carts_on_variant_id        (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_session_id => guest_sessions.id)
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (variant_id => variants.id)
#
