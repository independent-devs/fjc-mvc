# frozen_string_literal: true

FactoryBot.define do
  # base category
  factory :category do
    name { 'Categories' }
    ancestry { nil }
    ancestry_depth { 0 }
  end
end

# == Schema Information
#
# Table name: categories
#
#  id             :uuid             not null, primary key
#  ancestry       :string
#  ancestry_depth :integer          default(0)
#  name           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_categories_on_ancestry           (ancestry)
#  index_categories_on_name_and_ancestry  (name,ancestry) UNIQUE
#
