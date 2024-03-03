# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :variants, dependent: :destroy

  ## scopes
  scope :sort_by_latest, -> { order(id: :desc) }
  scope :base_on_date, lambda { |now = DateTime.now|
    where('products.available_on >= ?', now)
      .where('products.discontinue_on IS NULL OR products.discontinue_on <= ?', now)
  }
end

# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  available_on     :datetime
#  captured_price   :text
#  deleted_at       :datetime
#  description      :text
#  discontinue_on   :datetime
#  meta_description :text
#  meta_keywords    :string
#  meta_title       :string
#  name             :string           not null
#  promotionable    :boolean          default(FALSE), not null
#  slug             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_products_on_available_on    (available_on)
#  index_products_on_deleted_at      (deleted_at)
#  index_products_on_discontinue_on  (discontinue_on)
#  index_products_on_name            (name)
#  index_products_on_slug            (slug) UNIQUE
#
