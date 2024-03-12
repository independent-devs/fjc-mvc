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
#  deleted_at :datetime
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#
# Indexes
#
#  index_categories_on_deleted_at  (deleted_at)
#  index_categories_on_parent_id   (parent_id)
#  index_categories_on_position    (position)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => categories.id)
#
