# frozen_string_literal: true

class Category < ApplicationRecord
  # Constants
  MAX_DEPTH = 4

  # Relations
  has_ancestry cache_depth: true

  # Scopes
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :base_root, -> { find_by(ancestry: nil) }

  # Validations
  validates :name, presence: true,
                   uniqueness: { scope: :ancestry, message: I18n.t('categories.validate.unique_name_with_ancestry') }
  validates :ancestry_depth,
            inclusion: {
              message: I18n.t('categories.validate.ancestry_depth'),
              in: 1..MAX_DEPTH
            }, if: -> { ancestry.present? }
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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_categories_on_ancestry           (ancestry)
#  index_categories_on_deleted_at         (deleted_at)
#  index_categories_on_name_and_ancestry  (name,ancestry) UNIQUE
#
