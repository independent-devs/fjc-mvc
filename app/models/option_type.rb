# frozen_string_literal: true

class OptionType < ApplicationRecord
  has_many :options, dependent: :destroy
end
