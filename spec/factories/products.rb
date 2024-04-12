# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    currency { MoneyRails.default_currency }
    master_variant_attributes do
      { price: 100.00, cost: 80.00, is_master: true }
    end
    description_attributes do
      { description: Faker::Lorem.paragraph_by_chars }
    end
    seo_attributes do
      {
        meta_title: Faker::Commerce.product_name,
        meta_description: Faker::Lorem.paragraph_by_chars,
        meta_keywords: Faker::Commerce.department
      }
    end
  end
end
