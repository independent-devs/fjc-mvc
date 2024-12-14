# frozen_string_literal: true
# typed: true

class Category < ApplicationRecord
  # Constants
  MAX_DEPTH = 3

  # Relations
  has_ancestry cache_depth: true, primary_key_format: '[-A-Fa-f0-9]{36}'

  # Scopes
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :root, -> { find_by(ancestry: nil) }

  # Validations
  validates :name, presence: true, uniqueness: {
    scope: :ancestry, message: I18n.t('categories.validate.unique_name_with_ancestry')
  }
  validates :ancestry_depth,
            inclusion: {
              in: 1..MAX_DEPTH,
              message: I18n.t('categories.validate.ancestry_depth')
            }, if: :ancestry
end

# == Schema Information
#
# Table name: categories
#
#  id             :uuid             not null, primary key
#  ancestry       :string
#  ancestry_depth :integer          default(0)
#  name           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_categories_on_ancestry           (ancestry)
#  index_categories_on_name_and_ancestry  (name,ancestry) UNIQUE
#
