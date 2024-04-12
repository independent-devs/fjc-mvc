# frozen_string_literal: true

FactoryBot.define do
  factory :seo do
    product { create(:product) }
    meta_title { Faker::Commerce.product_name }
    meta_description { Faker::Lorem.paragraph_by_chars }
    meta_keywords { Faker::Commerce.department }
  end
end

# == Schema Information
#
# Table name: seos
#
#  id               :bigint           not null, primary key
#  meta_description :string
#  meta_keywords    :string
#  meta_title       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :bigint           not null
#
# Indexes
#
#  index_seos_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
