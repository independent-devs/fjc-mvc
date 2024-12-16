# frozen_string_literal: true

FactoryBot.define do
  factory :product_option do
    product { Product.last || create(:product) }
    option { Option.last || create(:option) }
    position { 0 }
  end
end

# == Schema Information
#
# Table name: product_options
#
#  id         :uuid             not null, primary key
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  option_id  :uuid             not null
#  product_id :uuid             not null
#
# Indexes
#
#  index_product_options_on_option_id   (option_id)
#  index_product_options_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (option_id => options.id)
#  fk_rails_...  (product_id => products.id)
#
