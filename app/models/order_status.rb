# frozen_string_literal: true

class OrderStatus < ApplicationRecord
  # constants
  STATUS = %w[pending to_ship to_recieve fulfilled unfullfilled].freeze

  # Relations
  has_many :order, dependent: :destroy

  # Scopes
  scope :pending, -> { find_by!(name: :pending) }
  scope :to_ship, -> { find_by!(name: :to_ship) }
  scope :to_recieve, -> { find_by!(name: :to_recieve) }
  scope :fulfilled, -> { find_by!(name: :fulfilled) }
  scope :unfulfilled, -> { find_by!(name: :unfulfilled) }
  scope :cancelled, -> { find_by!(name: :cancelled) }
  scope :returned, -> { find_by!(name: :returned) }
  scope :refunded, -> { find_by!(name: :refunded) }

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
