# frozen_string_literal: true

class Variant < ApplicationRecord
  acts_as_list

  belongs_to :product
  has_one :image, dependent: :destroy

  scope :sort_by_position, -> { order(:position) }
  scope :get_master, -> { where(is_master: true).first }
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :not_master, -> { where(is_master: false) }

  validates :price, presence: true
  validates :name, presence: true, if: -> { !is_master }

  validate :master_delete_attempt, if: :deleted_at_changed?
  validate :count_on_hand_validation
  validate :cost_validation, if: -> { cost.present? }
  validate :price_validation, if: -> { price.present? }

  after_update :capture_price, if: proc { |pv| pv.price_changed? || pv.deleted_at_changed? }
  after_save :capture_price

  private

  def capture_price
    pvariant = product.variants.not_deleted
    more_than_one = pvariant.count > 1

    captured = pvariant.where(is_master: !more_than_one)

    product.update!(lowest_price: captured.minimum(:price),
                    highest_price: captured.maximum(:price),
                    has_variant: more_than_one)
  end

  def master_delete_attempt
    return unless is_master && deleted_at.present?

    errors.add(:is_master, 'cannot delete a master variant')
  end

  def count_on_hand_validation
    return unless count_on_hand.nil? || count_on_hand.blank? || count_on_hand.negative?

    errors.add(:count_on_hand, 'must be greater than or equal to zero')
  end

  def cost_validation
    return unless cost.negative?

    errors.add(:cost, 'must be greater than or equal to zero')
  end

  def price_validation
    return unless price.negative?

    errors.add(:price, 'must be greater than or equal to zero')
  end
end

# == Schema Information
#
# Table name: variants
#
#  id            :bigint           not null, primary key
#  cost          :decimal(10, 2)
#  count_on_hand :integer          default(0)
#  deleted_at    :datetime
#  is_master     :boolean          default(FALSE), not null
#  name          :string
#  position      :integer
#  price         :decimal(10, 2)   not null
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
