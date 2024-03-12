# frozen_string_literal: true

class Variant < ApplicationRecord
  acts_as_list

  belongs_to :product
  has_one :image, dependent: :destroy

  scope :sort_by_position, -> { order(:position) }
  scope :get_master, -> { where(is_master: true).first }
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :not_master, -> { where(is_master: false) }

  validates :sell_price, presence: true, numericality: { grater_than_or_equal_to: 0 }
  validate :master_delete_attempt, if: :deleted_at_changed?

  after_update :capture_price, if: proc { |pv| pv.sell_price_changed? || pv.deleted_at_changed? }
  after_save :capture_price

  private

  def capture_price
    pvariant = product.variants
    more_than_one = pvariant.count > 1

    captured = pvariant.select('MIN(sell_price), MAX(sell_price)')
                       .where(is_master: !more_than_one).not_deleted
                       .group(:id).first

    return if captured.blank?

    product.update!(lowest_price: captured.min, highest_price: captured.max, has_variant: more_than_one)
  end

  def master_delete_attempt
    return unless is_master && deleted_at.present?

    errors.add(:is_master, 'cannot delete a master variant')
  end
end

# == Schema Information
#
# Table name: variants
#
#  id            :bigint           not null, primary key
#  cost_price    :decimal(10, 2)
#  count_on_hand :integer          default(0)
#  deleted_at    :datetime
#  is_master     :boolean          default(FALSE), not null
#  position      :integer
#  sell_price    :decimal(10, 2)   not null
#  sku           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_id    :bigint           not null
#
# Indexes
#
#  index_variants_on_deleted_at  (deleted_at)
#  index_variants_on_position    (position)
#  index_variants_on_product_id  (product_id)
#  index_variants_on_sku         (sku)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
