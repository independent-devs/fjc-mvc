# frozen_string_literal: true

class Option < ApplicationRecord
  include RankedModel

  # Relations
  has_many :product_option, dependent: :destroy

  # Scopes
  scope :sort_by_position, -> { rank(:sort_order) }
  scope :not_deleted, -> { where(deleted_at: nil) }

  # Position
  ranks :sort_order, column: :position

  validates :name, presence: true
  validates :name, uniqueness: true
end

# == Schema Information
#
# Table name: options
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  display_name :string
#  name         :string           not null
#  placeholder  :string
#  position     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_options_on_name  (name) UNIQUE
#
