# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Seo, type: :model do
  let(:seo) { build(:seo) }

  it 'create seo' do
    expect(seo).to be_valid
    expect(seo.meta_title).to be_present
    expect(seo.meta_description).to be_present
    expect(seo.meta_keywords).to be_present
    expect(seo.product).to be_present
  end
end

# == Schema Information
#
# Table name: seos
#
#  id               :uuid             not null, primary key
#  meta_description :string
#  meta_keywords    :string
#  meta_title       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :uuid             not null
#
# Indexes
#
#  index_seos_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
