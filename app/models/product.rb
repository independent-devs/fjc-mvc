# frozen_string_literal: true

class Product < ApplicationRecord
  # Relations
  has_many :variants, dependent: :destroy
  has_many :images, dependent: :destroy
  has_one :product_category, dependent: :destroy
  has_one :description, dependent: :destroy

  # Nested form
  accepts_nested_attributes_for :variants
  accepts_nested_attributes_for :description

  # Scopes
  scope :sort_by_latest, -> { order(id: :desc) }
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :single_public, ->(slug, uuid) { find_by!(slug:, uuid:, deleted_at: nil) }
  scope :base_on_date, lambda { |now = DateTime.now|
    where('available_on >= ?', now)
      .where('discontinue_on IS NULL OR discontinue_on <= ?', now)
  }

  # Validations
  validates :name, presence: true
  validates :slug, presence: true
  validates :uuid, uniqueness: true
  validates :rating, numericality: { in: 0..5 }
  validates :lowest_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :highest_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :currency, presence: true

  # Generators
  before_save :sanitize_name, if: :name_changed?

  private

  def sanitize_name
    self.name = name.gsub(/\?|\s+|=|%|(?-mix:\s)/, '-')
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
#  promotionable    :boolean          default(TRUE), not null
#  raters           :integer          default(0)
#  rating           :decimal(1, 1)    default(0.0)
#  require_login    :boolean          default(FALSE), not null
#  slug             :string           not null
#  uuid             :uuid             not null
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
