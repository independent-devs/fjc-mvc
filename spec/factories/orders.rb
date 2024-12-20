# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user { User.last || create(:user) }
    order_status { OrderStatus.first || create(:order_status) }
    guest_session { GuestSession.last || create(:guest_session) }
  end
end

# == Schema Information
#
# Table name: orders
#
#  id               :uuid             not null, primary key
#  tag              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  guest_session_id :uuid
#  order_status_id  :uuid             not null
#  user_id          :uuid
#
# Indexes
#
#  index_orders_on_guest_session_id  (guest_session_id)
#  index_orders_on_order_status_id   (order_status_id)
#  index_orders_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_session_id => guest_sessions.id)
#  fk_rails_...  (order_status_id => order_statuses.id)
#  fk_rails_...  (user_id => users.id)
#
