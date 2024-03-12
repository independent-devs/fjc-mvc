# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :product_categories, dependent: :destroy
end

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_deleted_at  (deleted_at)
#  index_categories_on_position    (position)
#
