# frozen_string_literal: true
# typed: true

class Category < ApplicationRecord
  # Concerns
  include ActiveStorage::Attached::Model

  # Constants
  MAX_DEPTH = 3

  # Attachments
  has_one_attached :thumbnail do |attachable|
    attachable.variant :small, resize_to_limit: [100, 100]
    attachable.variant :card, resize_to_limit: [320, 320]
  end

  # Relations
  has_many :product_categories, dependent: :destroy
  has_ancestry cache_depth: true, primary_key_format: '[-A-Fa-f0-9]{36}'

  # Scopes
  scope :roots, -> { where(ancestry: nil) }
  scope :order_by_name, -> { order(name: :asc) }

  # Validations
  validates :ancestry_depth, inclusion: { in: 0..MAX_DEPTH, message: I18n.t('categories.validate.ancestry_depth') }
  validates :name, presence: true, uniqueness: {
    scope: :ancestry, message: I18n.t('categories.validate.unique_name_with_ancestry')
  }
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
