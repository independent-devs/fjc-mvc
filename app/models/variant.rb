# frozen_string_literal: true

class Variant < ApplicationRecord
  # Concerns
  include RankedModel

  # Relations
  belongs_to :product

  has_many :variant_option_values, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :order_items, dependent: :nullify

  # Nested form
  accepts_nested_attributes_for :variant_option_values

  # Scopes
  scope :sort_by_position, -> { rank(:sort_order) }
  scope :not_master, -> { where(is_master: false) }
  scope :master, -> { where(is_master: true) }
  scope :stock_sum, -> { sum(:count_on_hand) }
  scope :grouped_option_name,
        lambda {
          select("variants.*, STRING_AGG(vov.name, ', ' ORDER BY po.position) AS grouped_name")
            .joins('LEFT JOIN variant_option_values AS vov ON variants.id = vov.variant_id')
            .joins('LEFT JOIN product_options AS po ON po.id = vov.product_option_id')
            .group('variants.id, vov.variant_id')
        }

  # Position
  ranks :sort_order, column: :position, with_same: :product_id

  # Validations
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, only_float: true }
  validates :cost, numericality: { greater_than_or_equal_to: 0, only_float: true }, allow_nil: true
  validates :variant_option_values, presence: true, unless: :is_master
  validates :count_on_hand, presence: true

  validate :only_one_master, if: :only_one_master_condition
  validate :product_supports_variant, unless: :is_master
  validate :unique_option_values_per_variant

  # Generators
  before_destroy :capture_order_item_variants, prepend: true

  after_destroy :capture_price
  after_save :capture_price, if: :price_previously_changed?

  def option_value_name
    variant_option_values.joins(:product_option).order('product_options.position').pluck(:name).join(', ')
  end

  private

  # For generators
  def capture_order_item_variants
    order_items.each do |order_item|
      order_item.update(
        {
          variant_capture: {
            product_name: product.name,
            product_id: product.id,
            variant_name: option_value_name,
            variant_master: is_master
          }
        }
      )
    end
  end

  def capture_price
    variants = product.variants
    no_variant_records = variants.not_master.count.zero?
    captured = variants.where(is_master: no_variant_records)

    product.update(lowest_price: captured.minimum(:price), highest_price: captured.maximum(:price))
  end

  # For validations
  def only_one_master
    return unless product.variants.exists?(is_master: true)

    errors.add(:master, I18n.t('variants.validate.only_one_master'))
  end

  def only_one_master_condition
    (new_record? && is_master) || (is_master_changed? && is_master_was) || false
  end

  def product_supports_variant
    return if product.has_variant

    errors.add(:product, I18n.t('variants.validate.variant_not_supported'))
  end

  def unique_option_values_per_variant
    existing_sets =
      VariantOptionValue
      .select(:variant_id, 'ARRAY_AGG(name ORDER BY product_option_id) AS option_values')
      .where(product_option_id: product.product_options.pluck(:id))
      .group(:variant_id)

    existing_sets = existing_sets.where.not(variant: self) unless new_record?
    existing_sets = existing_sets.map(&:option_values)

    current_set = variant_option_values.sort_by(&:product_option_id).map(&:name)

    return unless existing_sets.include?(current_set)

    errors.add(:variant_option_values, I18n.t('variants.validate.variant_option_values_unique'))
  end
end

# == Schema Information
#
# Table name: variants
#
#  id            :uuid             not null, primary key
#  backorderable :boolean          default(FALSE), not null
#  cost          :decimal(10, 2)
#  count_on_hand :integer          default(0), not null
#  is_master     :boolean          default(FALSE), not null
#  position      :integer
#  price         :decimal(10, 2)   not null
#  sku           :string
#  trackable     :boolean          default(TRUE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_id    :uuid             not null
#
# Indexes
#
#  index_variants_on_position    (position)
#  index_variants_on_product_id  (product_id)
#  index_variants_on_sku         (sku)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
