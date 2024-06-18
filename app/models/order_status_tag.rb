# frozen_string_literal: true

class OrderStatusTag < ApplicationRecord
  # Relations
  belongs_to :order
  belongs_to :order_tag

  # Validations
  validate :same_order_status

  private

  def same_order_status
    return if order.order_status_id == order_tag.order_status_id

    errors.add(:order_status, 'must be the same as the order status')
  end
end

# == Schema Information
#
# Table name: order_status_tags
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  order_id     :bigint           not null
#  order_tag_id :bigint           not null
#
# Indexes
#
#  index_order_status_tags_on_order_id      (order_id)
#  index_order_status_tags_on_order_tag_id  (order_tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (order_tag_id => order_tags.id)
#
