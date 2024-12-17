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
#  id               :uuid             not null, primary key
#  qty              :integer          default(1), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  guest_session_id :uuid
#  user_id          :uuid
#  variant_id       :uuid             not null
#
# Indexes
#
#  index_carts_on_guest_session_id                             (guest_session_id)
#  index_carts_on_user_id                                      (user_id)
#  index_carts_on_variant_id                                   (variant_id)
#  index_carts_on_variant_id_and_user_id_and_guest_session_id  (variant_id,user_id,guest_session_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (guest_session_id => guest_sessions.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (variant_id => variants.id)
#
