# frozen_string_literal: true

class Product < ApplicationRecord
  include Rails.application.routes.url_helpers

  # Constants
  SLUG_REGEX = { ';' => ' ', '/' => ' ', '?' => ' ', ':' => ' ', '@' => ' ',
                 '&' => ' ', '=' => ' ', '+' => ' ', ',' => ' ', '.' => '' }.freeze

  # Attachments
  has_many_attached :images do |attachable|
    attachable.variant :small, resize_to_limit: [100, 100]
    attachable.variant :thumb, resize_to_limit: [320, 320]
  end
  has_one_attached :thumbnail do |attachable|
    attachable.variant :small, resize_to_limit: [100, 100]
    attachable.variant :card, resize_to_limit: [320, 320]
  end

  # Relations
  has_one :product_category, dependent: :destroy
  has_one :description, dependent: :destroy
  has_one :seo, dependent: :destroy
  has_many :variants, dependent: :destroy
  has_many :product_options, dependent: :destroy
  has_many :options, through: :product_options

  # Scoped relations
  has_one :master_variant, -> { where(is_master: true) },
          class_name: 'Variant', inverse_of: :product,
          dependent: :destroy
  has_one :master_category, -> { where(is_master: true) },
          class_name: 'ProductCategory', inverse_of: :product,
          dependent: :destroy
  has_many :non_master_variants, -> { where(is_master: false) },
           class_name: 'Variant', inverse_of: :product,
           dependent: :destroy
  has_many :non_master_categories, -> { where(is_master: false) },
           class_name: 'ProductCategory', inverse_of: :product,
           dependent: :destroy

  # Nested form
  accepts_nested_attributes_for :master_variant, :description, :product_category, :seo

  # Scopes
  scope :sort_by_latest, -> { order(id: :desc) }
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :single_public, ->(slug, uuid) { find_by!(slug:, uuid:, deleted_at: nil) }
  scope :single_using_uuid, ->(uuid) { find_by!(uuid:, deleted_at: nil) }
  scope :base_on_date, lambda { |now = DateTime.now|
    where(available_on: now..)
      .where('discontinue_on IS NULL OR discontinue_on <= ?', now)
  }

  # Validations
  validates :name, :currency, :master_variant, :slug, presence: true
  validates :options, presence: true, if: :has_variant
  validates :review_avg_rating, numericality: { in: 0..5 }
  validates :lowest_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :highest_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :slug, format: { without: Regexp.union(SLUG_REGEX.keys) }

  # Generators
  before_validation :sanitize_slug, if: proc { |pr| pr.new_record? || pr.slug_changed? }
  after_save :generate_thumbnail_url, if: :generate_thumbnail_url_condition

  private

  # For generators
  def sanitize_slug
    keys = Regexp.union(SLUG_REGEX.keys)
    to_sanitize = new_record? ? name : slug

    self.slug = to_sanitize.gsub(keys, SLUG_REGEX).rstrip.gsub(/\s+/, '-')
  end

  def generate_thumbnail_url_condition
    attachment_changes['thumbnail'].present?
  end

  def generate_thumbnail_url
    # rubocop:disable Rails::SkipsModelValidations
    update_column(:thumbnail_url, url_for(thumbnail.variant(:card)))
    # rubocop:enable Rails::SkipsModelValidations
  end
end

# == Schema Information
#
# Table name: products
#
#  id                :bigint           not null, primary key
#  available_on      :datetime
#  currency          :string           not null
#  deleted_at        :datetime
#  discontinue_on    :datetime
#  has_variant       :boolean          default(FALSE), not null
#  highest_price     :decimal(10, 2)
#  lowest_price      :decimal(10, 2)
#  name              :string           not null
#  order_must_login  :boolean          default(FALSE), not null
#  promotable        :boolean          default(TRUE), not null
#  review_avg_rating :decimal(1, 1)    default(0.0)
#  review_count      :integer          default(0)
#  slug              :string           not null
#  thumbnail_url     :string
#  uuid              :uuid             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
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
