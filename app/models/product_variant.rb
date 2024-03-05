# frozen_string_literal: true

class ProductVariant < ApplicationRecord
  belongs_to :product

  validates :sell_price, presence: true
  scope :sort_by_position, -> { order(position: :asc) }
  scope :get_master, -> { where(is_master: true).first }

  after_update :capture_price, if: :sell_price_changed?
  after_save :capture_price

  private

  def capture_price
    captured = product.product_variants.select('MIN(sell_price), MAX(sell_price)')
                      .group(:id).first

    return if captured.blank?

    product.update(lowest_price: captured.min, highest_price: captured.max)
  end
end

# == Schema Information
#
# Table name: product_variants
#
#  id            :bigint           not null, primary key
#  cost_price    :decimal(10, 2)
#  count_on_hand :integer          default(0)
#  deleted_at    :datetime
#  is_master     :boolean          default(FALSE), not null
#  position      :integer          default(1), not null
#  sell_price    :decimal(10, 2)   not null
#  sku           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_id    :bigint           not null
#
# Indexes
#
#  index_product_variants_on_position    (position)
#  index_product_variants_on_product_id  (product_id)
#  index_product_variants_on_sku         (sku)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
