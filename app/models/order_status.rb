# frozen_string_literal: true
# typed: true

class OrderStatus < ApplicationRecord
  # Relations
  has_many :order, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true
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
