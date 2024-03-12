# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  belongs_to :product
  belongs_to :category
end

# == Schema Information
#
# Table name: product_categories
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  product_id  :bigint           not null
#
# Indexes
#
#  index_product_categories_on_category_id                 (category_id)
#  index_product_categories_on_deleted_at                  (deleted_at)
#  index_product_categories_on_product_id                  (product_id)
#  index_product_categories_on_product_id_and_category_id  (product_id,category_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (product_id => products.id)
#
