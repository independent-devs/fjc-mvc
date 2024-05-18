# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user { User.last || create(:user) }
    order_status { OrderStatus.last || create(:order_status) }
  end
end

# == Schema Information
#
# Table name: orders
#
#  id              :bigint           not null, primary key
#  uuid            :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_status_id :bigint           not null
#  user_id         :bigint
#
# Indexes
#
#  index_orders_on_order_status_id  (order_status_id)
#  index_orders_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_status_id => order_statuses.id)
#  fk_rails_...  (user_id => users.id)
#
