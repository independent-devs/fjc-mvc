# frozen_string_literal: true

FactoryBot.define do
  factory :variant_option_value do
    variant { nil }
    product_option { nil }
    name { 'MyString' }
  end
end

# == Schema Information
#
# Table name: variant_option_values
#
#  id                :bigint           not null, primary key
#  name              :string           not null
#  position          :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  product_option_id :bigint           not null
#  variant_id        :bigint           not null
#
# Indexes
#
#  index_variant_option_values_on_product_option_id  (product_option_id)
#  index_variant_option_values_on_variant_id         (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_option_id => product_options.id)
#  fk_rails_...  (variant_id => variants.id)
#
