# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { build(:product) }

  it 'create product' do
    expect(product).to be_valid
    expect(product.name).to be_present
    expect(product.currency).to be_present

    # check nested attributes
    expect(product.seo).to be_present
    expect(product.master_variant).to be_present

    # after save (generators)
    product.save
    expect(product.lowest_price).to be_present
    expect(product.highest_price).to be_present
  end
end

# == Schema Information
#
# Table name: products
#
#  id                :uuid             not null, primary key
#  available_on      :date
#  currency          :string           not null
#  discontinue_on    :date
#  has_variant       :boolean          default(FALSE), not null
#  highest_price     :decimal(10, 2)
#  lowest_price      :decimal(10, 2)
#  name              :string           not null
#  order_must_login  :boolean          default(FALSE), not null
#  promotable        :boolean          default(TRUE), not null
#  review_avg_rating :decimal(1, 1)    default(0.0)
#  review_count      :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_products_on_available_on    (available_on)
#  index_products_on_discontinue_on  (discontinue_on)
#  index_products_on_highest_price   (highest_price)
#  index_products_on_lowest_price    (lowest_price)
#  index_products_on_name            (name)
#
