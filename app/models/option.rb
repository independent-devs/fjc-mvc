# frozen_string_literal: true

class Option < ApplicationRecord
  include RankedModel

  # Scopes
  scope :sort_by_position, -> { rank(:sort_order) }

  # Position
  ranks :sort_order, column: :position

  validates :name, presence: true
end

# == Schema Information
#
# Table name: options
#
#  id         :bigint           not null, primary key
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
