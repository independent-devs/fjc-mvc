# frozen_string_literal: true

FactoryBot.define do
  factory :variant_option_value do
    product_option { ProductOption.last || create(:product_option) }
    name { Faker::Commerce.brand }
    variant { create(:variant) }
    position { 0 }
  end
end

# == Schema Information
#
# Table name: variant_option_values
#
#  id                :uuid             not null, primary key
#  illustration      :string           default(""), not null
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  product_option_id :uuid             not null
#  variant_id        :uuid             not null
#
# Indexes
#
#  index_variant_option_values_on_name                              (name)
#  index_variant_option_values_on_product_option_id                 (product_option_id)
#  index_variant_option_values_on_variant_id                        (variant_id)
#  index_variant_option_values_on_variant_id_and_product_option_id  (variant_id,product_option_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (product_option_id => product_options.id)
#  fk_rails_...  (variant_id => variants.id)
#
