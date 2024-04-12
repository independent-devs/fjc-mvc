# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }

  it 'create product ' do
    expect(product.name).to be_present
    expect(product.slug).to be_present
    expect(product.currency).to be_present
    expect(product.lowest_price).to be_present
    expect(product.highest_price).to be_present

    # check nested attributes
    expect(product.description).to be_present
    expect(product.seo).to be_present
    expect(product.master_variant).to be_present
  end
end
