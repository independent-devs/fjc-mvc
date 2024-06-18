# frozen_string_literal: true

class OrderItem < ApplicationRecord
  # Relations
  belongs_to :order
  belongs_to :variant

  # Validations
  validates :qty, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, only_float: true }
  validate :check_variant_quantity

  private

  def check_variant_quantity
    return if variant.backorderable || variant.count_on_hand > qty

    errors.add(:variant, 'out of stock.')
  end
end

# == Schema Information
#
# Table name: order_items
#
#  id         :bigint           not null, primary key
#  price      :decimal(10, 2)   not null
#  qty        :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#  variant_id :bigint           not null
#
# Indexes
#
#  index_order_items_on_order_id    (order_id)
#  index_order_items_on_variant_id  (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (variant_id => variants.id)
#
