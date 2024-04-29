# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Description, type: :model do
  let(:description) { create(:description) }

  it 'create description' do
    expect(description.description).to be_present
    expect(description.product).to be_present
  end
end

# == Schema Information
#
# Table name: descriptions
#
#  id          :bigint           not null, primary key
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint           not null
#
# Indexes
#
#  index_descriptions_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
