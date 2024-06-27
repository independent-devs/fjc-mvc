# frozen_string_literal: true
# typed: true

class OrderItem < ApplicationRecord
  # Relations
  belongs_to :order, optional: true
  belongs_to :variant, optional: true

  # Validations
  validates :qty, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, only_float: true }
  validate :check_variant_quantity, if: :variant

  private

  def check_variant_quantity
    return if T.must(variant).backorderable || (T.must(T.must(variant).count_on_hand) > qty)

    errors.add(:variant, I18n.t('variants.validate.variant_out_of_stock'))
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
#  order_id   :bigint
#  variant_id :bigint
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
