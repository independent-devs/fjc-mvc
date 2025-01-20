# frozen_string_literal: true

class OrderStatus < ApplicationRecord
  # Relations
  has_many :order, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true

  def self.pending
    find_by(name: 'pending')
  end

  def self.to_ship
    find_by(name: 'to_ship')
  end

  def self.to_recieve
    find_by(name: 'to_recieve')
  end

  def self.completed
    find_by(name: 'completed')
  end

  def self.cancelled
    find_by(name: 'cancelled')
  end

  def self.returned
    find_by(name: 'returned')
  end

  def self.refunded
    find_by(name: 'refunded')
  end
end

# == Schema Information
#
# Table name: order_statuses
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_order_statuses_on_name  (name) UNIQUE
#
