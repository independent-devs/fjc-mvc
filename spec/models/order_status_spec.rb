# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderStatus, type: :model do
  let(:order_status) { build(:order_status) }

  it 'Create order status' do
    expect(order_status).to be_valid
    expect(order_status.name).to be_present
  end
end

# == Schema Information
#
# Table name: order_statuses
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_order_statuses_on_name  (name) UNIQUE
#
