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
end

# == Schema Information
#
# Table name: options
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  name        :string           not null
#  placeholder :string
#  position    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
