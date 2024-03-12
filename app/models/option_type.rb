# frozen_string_literal: true

class OptionType < ApplicationRecord
  has_many :options, dependent: :destroy

  scope :not_deleted, -> { where(deleted_at: nil) }
end

# == Schema Information
#
# Table name: option_types
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_option_types_on_deleted_at  (deleted_at)
#
