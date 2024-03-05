# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :product_variants, dependent: :destroy
  accepts_nested_attributes_for :product_variants

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :rating, numericality: { in: 0..5 }

  ## scopes
  scope :sort_by_latest, -> { order(id: :desc) }
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :has_captured_price, -> { where('lowest_price IS NOT NULL AND highest_price IS NOT NULL') }
  scope :base_on_date, lambda { |now = DateTime.now|
    where('available_on >= ?', now).where('discontinue_on IS NULL OR discontinue_on <= ?', now)
  }
end

# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  available_on     :datetime
#  deleted_at       :datetime
#  description      :text
#  discontinue_on   :datetime
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
#  index_products_on_slug            (slug) UNIQUE
#
