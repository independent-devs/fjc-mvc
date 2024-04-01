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
#  id             :bigint           not null, primary key
#  ancestry       :string
#  ancestry_depth :integer          default(0)
#  deleted_at     :datetime
#  name           :string           not null
#  position       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_categories_on_ancestry           (ancestry)
#  index_categories_on_deleted_at         (deleted_at)
#  index_categories_on_name_and_ancestry  (name,ancestry) UNIQUE
#  index_categories_on_position           (position)
#
