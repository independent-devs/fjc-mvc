# frozen_string_literal: true

FactoryBot.define do
  factory :variant do
    product { create(:product, :with_variants) }
    is_master { false }
    cost { Faker::Commerce.price }
    count_on_hand { 1000 }
    trackable { true }
    backorderable { false }
    price { Faker::Commerce.price }
    sku { Faker::Barcode.ean(13) }
  end
end

# == Schema Information
#
# Table name: variants
#
#  id            :bigint           not null, primary key
#  backorderable :boolean          default(FALSE), not null
#  cost          :decimal(10, 2)
#  count_on_hand :integer          default(0)
#  is_master     :boolean          default(FALSE), not null
#  position      :integer
#  price         :decimal(10, 2)   not null
#  sku           :string
#  thumbnail_url :string
#  trackable     :boolean          default(TRUE), not null
#  uuid          :uuid             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_id    :bigint           not null
#
# Indexes
#
#  index_variants_on_position    (position)
#  index_variants_on_product_id  (product_id)
#  index_variants_on_sku         (sku)
#  index_variants_on_uuid        (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
