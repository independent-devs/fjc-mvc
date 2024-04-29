# frozen_string_literal: true

FactoryBot.define do
  factory :description do
    description { Faker::Lorem.paragraph_by_chars }
    product { Product.last || create(:product) }
  end
end

# == Schema Information
#
# Table name: descriptions
#
#  id          :bigint           not null, primary key
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint           not null
#
# Indexes
#
#  index_descriptions_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
