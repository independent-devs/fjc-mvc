# frozen_string_literal: true

class Variant < ApplicationRecord
  include RankedModel

  # Relations
  belongs_to :product
  has_one :image, dependent: :destroy

  # Scopes
  scope :sort_by_position, -> { rank(:sort_order) }
  scope :get_master, -> { where(is_master: true).first }
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :not_master, -> { where(is_master: false) }

  # Position
  ranks :sort_order, column: :position, with_same: :product_id, scope: :not_deleted

  # Validations
  validates :name, presence: true, if: -> { !is_master }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, only_float: true }
  validates :cost, numericality: { greater_than_or_equal_to: 0, only_float: true }, allow_nil: true
  validates :count_on_hand, numericality: { greater_than_or_equal_to: 0 }

  validate :master_delete_attempt, if: :deleted_at_changed?
  validate :only_one_master, if: :only_one_master_condition

  # Generators
  after_save :capture_price, if: :capture_price_condition

  private

  def capture_price_condition
    price_previously_changed? || deleted_at_previously_changed?
  end

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

    errors.add(:master, I18n.t('variants.validate.master_delete_attempt'))
  end

  def only_one_master_condition
    new_record? && is_master
  end

  def only_one_master
    return unless product.variants.exists?(is_master: true)

    errors.add(:master, I18n.t('variants.validate.only_one_master'))
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
