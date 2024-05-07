# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Option, type: :model do
  let(:option) { create(:option) }

  it 'create option' do
    expect(option.name).to be_present
  end
end

# == Schema Information
#
# Table name: options
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#