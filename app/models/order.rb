# frozen_string_literal: true

class Order < ApplicationRecord
  # Relationships
  belongs_to :variant
  belongs_to :order_status
  belongs_to :user, optional: true

  # Validations
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end

# == Schema Information
#
# Table name: orders
#
#  id              :bigint           not null, primary key
#  quantity        :integer          default(1), not null
#  uuid            :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_status_id :bigint           not null
#  user_id         :bigint
#  variant_id      :bigint           not null
#
# Indexes
#
#  index_orders_on_order_status_id  (order_status_id)
#  index_orders_on_user_id          (user_id)
#  index_orders_on_variant_id       (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_status_id => order_statuses.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (variant_id => variants.id)
#
