# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  available_on     :datetime
#  deleted_at       :datetime
#  description      :text
#  discontinue_on   :datetime
#  has_variant      :boolean          default(FALSE), not null
#  highest_price    :decimal(10, 2)
#  lowest_price     :decimal(10, 2)
#  meta_description :text
#  meta_keywords    :string
#  meta_title       :string
#  name             :string           not null
#  promotionable    :boolean          default(TRUE), not null
#  raters           :integer          default(0)
#  rating           :decimal(1, 1)    default(0.0)
#  require_login    :boolean          default(FALSE), not null
#  slug             :string           not null
#  uuid             :uuid             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_products_on_available_on    (available_on)
#  index_products_on_deleted_at      (deleted_at)
#  index_products_on_discontinue_on  (discontinue_on)
#  index_products_on_highest_price   (highest_price)
#  index_products_on_lowest_price    (lowest_price)
#  index_products_on_name            (name)
#  index_products_on_slug            (slug)
#  index_products_on_uuid            (uuid) UNIQUE
#
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
