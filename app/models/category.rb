# frozen_string_literal: true

class Category < ApplicationRecord
  include RankedModel

  # Constants
  MAX_DEPTH = 4

  # Relations
  has_ancestry cache_depth: true

  # Scopes
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :base_root, -> { find_by(ancestry: nil) }

  # Position
  ranks :sort_order, column: :position, with_same: :ancestry, scope: :not_deleted

  # Validations
  validates :name, presence: true, uniqueness: { scope: :ancestry }
  validates :ancestry_depth, inclusion: { in: 1..MAX_DEPTH, message: I18n.t('categories.invalid.ancestry_depth') },
                             if: -> { ancestry.present? }
end

# == Schema Information
#
# Table name: categories
#
#  id             :bigint           not null, primary key
#  ancestry       :string
#  ancestry_depth :integer          default(0)
#  deleted_at     :datetime
#  name           :string           not null
#  position       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_categories_on_ancestry           (ancestry)
#  index_categories_on_deleted_at         (deleted_at)
#  index_categories_on_name_and_ancestry  (name,ancestry) UNIQUE
#  index_categories_on_position           (position)
#
