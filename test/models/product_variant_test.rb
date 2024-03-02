# frozen_string_literal: true

require 'test_helper'

class ProductVariantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: product_variants
#
#  id            :bigint           not null, primary key
#  cost_price    :decimal(10, 2)
#  count_on_hand :integer          default(0)
#  deleted_at    :datetime
#  is_master     :boolean          default(FALSE), not null
#  position      :integer          default(0), not null
#  sell_price    :decimal(10, 2)   not null
#  sku           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_id    :bigint           not null
#
# Indexes
#
#  index_product_variants_on_position    (position)
#  index_product_variants_on_product_id  (product_id)
#  index_product_variants_on_sku         (sku)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
