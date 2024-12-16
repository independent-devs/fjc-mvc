# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductOption, type: :model do
  let(:product_option) { build(:product_option) }

  it 'Create product option' do
    expect(product_option).to be_valid
    expect(product_option.product).to be_present
    expect(product_option.option).to be_present
    expect(product_option.position).to be_present
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
