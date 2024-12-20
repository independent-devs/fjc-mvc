# frozen_string_literal: true
# typed: true

class OrderItem < ApplicationRecord
  extend T::Sig

  # Relations
  belongs_to :order, optional: true
  belongs_to :variant, optional: true

  # Validations
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, only_float: true }
  validates :qty, numericality: { greater_than: 0 }

  validate :check_variant_stock, if: :variant

  private

  sig { void }
  def check_variant_stock
    return if T.must(variant).backorderable

    if T.must(T.must(variant).count_on_hand).zero?
      errors.add(:variant, I18n.t('variants.validate.variant_out_of_stock'))
      return
    end

    return if T.must(T.must(variant).count_on_hand) >= qty

    errors.add(:quantity, I18n.t('carts.validate.qty_exceeds_stocks'))
  end
end

# == Schema Information
#
# Table name: order_items
#
#  id         :uuid             not null, primary key
#  price      :decimal(10, 2)   not null
#  qty        :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :uuid
#  variant_id :uuid
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
