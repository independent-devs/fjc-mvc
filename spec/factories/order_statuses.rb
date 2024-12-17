# frozen_string_literal: true

FactoryBot.define do
  factory :order_status do
    name { 'pending' }
    step { 1 }
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
