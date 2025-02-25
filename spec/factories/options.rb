# frozen_string_literal: true

FactoryBot.define do
  factory :option do
    name { Faker::Commerce.material }
  end
end

# == Schema Information
#
# Table name: options
#
#  id           :uuid             not null, primary key
#  display_name :string
#  name         :string           not null
#  placeholder  :string
#  position     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_options_on_name  (name) UNIQUE
#
