# frozen_string_literal: true
# typed: true

class OrderStatus < ApplicationRecord
  # constants
  STATUSES = %w[pending to_ship to_recieve fulfilled unfulfilled].freeze
  UNFULFILLED_TAGS = %w[cancelled returned refunded].freeze

  # Relations
  has_many :order, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true, inclusion: { in: STATUSES }
  validates :step, presence: true, uniqueness: true
end

# == Schema Information
#
# Table name: order_statuses
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  step       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_order_statuses_on_name  (name) UNIQUE
#  index_order_statuses_on_step  (step) UNIQUE
#
