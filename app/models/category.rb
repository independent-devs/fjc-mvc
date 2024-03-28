# frozen_string_literal: true

class Category < ApplicationRecord
  include RankedModel

  # Relations
  has_ancestry

  # Scopes
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :sort_by_position, -> { rank(:sort_order) }
  scope :base_parents, -> { where(ancestry: nil) }

  # Position
  ranks :sort_order, column: :position, with_same: :ancestry, scope: :not_deleted

  # Validations
  validates :name, presence: true, uniqueness: { scope: :ancestry }
end

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  ancestry   :string
#  deleted_at :datetime
#  name       :string           not null
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_ancestry           (ancestry)
#  index_categories_on_deleted_at         (deleted_at)
#  index_categories_on_name_and_ancestry  (name,ancestry) UNIQUE
#  index_categories_on_position           (position)
#
