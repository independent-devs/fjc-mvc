# frozen_string_literal: true
# typed: true

class Variant < ApplicationRecord
  extend T::Sig

  # Helpers
  T.unsafe(self).include Rails.application.routes.url_helpers
  include ActiveStorage::Attached::Model
  include RankedModel

  # Attachments
  has_one_attached :thumbnail do |attachable|
    attachable.variant :small, resize_to_limit: [100, 100]
    attachable.variant :card, resize_to_limit: [320, 320]
  end

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
  scope :single_using_uuid, ->(uuid) { find_by!(uuid:) }
  scope :stock_sum, -> { sum(:count_on_hand) }
  scope :grouped_option_name,
        lambda {
          select("variants.*, STRING_AGG(vov.name, ', ' ORDER BY vov.position) AS grouped_name")
            .joins('LEFT JOIN variant_option_values AS vov ON variants.id = vov.variant_id')
            .group('variants.id, vov.variant_id')
        }

  # Position
  ranks :sort_order, column: :position, with_same: :product_id

  # Validations
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, only_float: true }
  validates :cost, numericality: { greater_than_or_equal_to: 0, only_float: true }, allow_nil: true
  validates :count_on_hand, numericality: { greater_than_or_equal_to: 0 }

  validate :only_one_master, if: :only_one_master_condition
  validate :product_supports_variant, unless: :is_master

  # Generators
  after_destroy :capture_price
  after_save :capture_price, if: :price_previously_changed?
  after_save :generate_thumbnail_url, if: :generate_thumbnail_url_condition

  private

  # For generators
  sig { void }
  def capture_price
    variants = T.must(product).variants
    no_variant_records = variants.not_master.count.zero?
    captured = variants.where(is_master: no_variant_records)

    T.must(product).update!(
      lowest_price: captured.minimum(:price),
      highest_price: captured.maximum(:price)
    )
  end

  # For validations
  sig { void }
  def only_one_master
    return unless T.must(product).variants.exists?(is_master: true)

    errors.add(:master, I18n.t('variants.validate.only_one_master'))
  end

  sig { returns(T.nilable(T::Boolean)) }
  def only_one_master_condition
    (new_record? && is_master) || (is_master_changed? && is_master_was)
  end

  sig { void }
  def product_supports_variant
    return if T.must(product).has_variant

    errors.add(:product, I18n.t('variants.validate.variant_not_supported'))
  end

  sig { void }
  def generate_thumbnail_url
    # rubocop:disable Rails::SkipsModelValidations
    update_column(:thumbnail_url, url_for(T.unsafe(thumbnail).variant(:card)))
    # rubocop:enable Rails::SkipsModelValidations
  end

  sig { returns(T::Boolean) }
  def generate_thumbnail_url_condition
    attachment_changes['thumbnail'].present?
  end
end

# == Schema Information
#
# Table name: variants
#
#  id            :bigint           not null, primary key
#  backorderable :boolean          default(FALSE), not null
#  cost          :decimal(10, 2)
#  count_on_hand :integer          default(0)
#  is_master     :boolean          default(FALSE), not null
#  position      :integer
#  price         :decimal(10, 2)   not null
#  sku           :string
#  thumbnail_url :string
#  trackable     :boolean          default(TRUE), not null
#  uuid          :uuid             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_id    :bigint           not null
#
# Indexes
#
#  index_variants_on_position    (position)
#  index_variants_on_product_id  (product_id)
#  index_variants_on_sku         (sku)
#  index_variants_on_uuid        (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
