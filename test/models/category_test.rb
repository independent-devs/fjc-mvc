# frozen_string_literal: true

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  position   :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
