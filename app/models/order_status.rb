# frozen_string_literal: true

class OrderStatus < ApplicationRecord
  # constants
  STATUS = %w[pending shipped unfulfilled fulfilled returned].freeze

  # Relations
  has_many :order, dependent: :destroy

  # Scopes
  scope :pending, -> { find_by!(name: :pending) }
  scope :shipped, -> { find_by!(name: :shipped) }
  scope :unfulfilled, -> { find_by!(name: :unfulfilled) }
  scope :fulfilled, -> { find_by!(name: :fulfilled) }
  scope :returned, -> { find_by!(name: :returned) }

  # Validations
  validates :name, presence: true, uniqueness: true, inclusion: { in: STATUS }
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
