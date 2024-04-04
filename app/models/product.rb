# frozen_string_literal: true

class Product < ApplicationRecord
  # Constants
  SLUG_REGEX = { ';' => ' ', '/' => ' ', '?' => ' ', ':' => ' ', '@' => ' ',
                 '&' => ' ', '=' => 'equal', ' ' => 'plus', ',' => ' ' }.freeze

  # Relations
  has_many :variants, dependent: :destroy
  has_many :images, dependent: :destroy
  has_one :product_category, dependent: :destroy
  has_one :description, dependent: :destroy

  # Scoped Relations
  has_one :master_variant, -> { where(is_master: true) },
          class_name: 'Variant', inverse_of: :product,
          dependent: :destroy
  has_many :non_master_variants, -> { where(is_master: false) },
           class_name: 'Variant', inverse_of: :product,
           dependent: :destroy

  # Nested form
  accepts_nested_attributes_for :master_variant, :description, :product_category

  # Scopes
  scope :sort_by_latest, -> { order(id: :desc) }
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :single_public, ->(slug, uuid) { find_by!(slug:, uuid:, deleted_at: nil) }
  scope :base_on_date, lambda { |now = DateTime.now|
    where('available_on >= ?', now)
      .where('discontinue_on IS NULL OR discontinue_on <= ?', now)
  }

  # Validations
  validates :name, :currency, :master_variant, :slug, presence: true
  validates :rating, numericality: { in: 0..5 }
  validates :lowest_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :highest_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :slug, format: { without: Regexp.union(SLUG_REGEX.keys) }

  # Generators
  before_validation :sanitize_slug, if: proc { |pr| pr.new_record? || pr.slug_changed? }

  private

  # For generators
  def sanitize_slug
    keys = Regexp.union(SLUG_REGEX.keys)
    to_sanitize = new_record? ? name : slug

    self.slug = to_sanitize.gsub(keys, SLUG_REGEX).rstrip.gsub(/\s+/, '-')
  end
end

# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  available_on     :datetime
#  currency         :string           not null
#  deleted_at       :datetime
#  discontinue_on   :datetime
#  has_variant      :boolean          default(FALSE), not null
#  highest_price    :decimal(10, 2)
#  lowest_price     :decimal(10, 2)
#  meta_description :text
#  meta_keywords    :string
#  meta_title       :string
#  name             :string           not null
#  order_must_login :boolean          default(FALSE), not null
#  promotable       :boolean          default(TRUE), not null
#  rate_count       :integer          default(0)
#  rating           :decimal(1, 1)    default(0.0)
#  slug             :string           not null
#  uuid             :uuid             not null
#  variant_label    :string           default("Variations"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_products_on_available_on    (available_on)
#  index_products_on_deleted_at      (deleted_at)
#  index_products_on_discontinue_on  (discontinue_on)
#  index_products_on_highest_price   (highest_price)
#  index_products_on_lowest_price    (lowest_price)
#  index_products_on_name            (name)
#  index_products_on_slug            (slug)
#  index_products_on_uuid            (uuid) UNIQUE
#
