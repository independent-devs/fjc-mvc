# frozen_string_literal: true

FactoryBot.define do
  factory :order_status do
    name { OrderStatus::STATUS.first }
    step { 1 }
  end
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
