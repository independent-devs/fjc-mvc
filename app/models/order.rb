# frozen_string_literal: true

class Order < ApplicationRecord
  # Relations
  belongs_to :user, optional: true
  belongs_to :order_status
end

# == Schema Information
#
# Table name: orders
#
#  id              :bigint           not null, primary key
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
