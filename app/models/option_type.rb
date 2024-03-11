# frozen_string_literal: true

class OptionType < ApplicationRecord
  has_many :options, dependent: :destroy
end

# == Schema Information
#
# Table name: option_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
