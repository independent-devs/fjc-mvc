# frozen_string_literal: true

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: images
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  position   :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  variant_id :bigint
#
# Indexes
#
#  index_images_on_deleted_at  (deleted_at)
#  index_images_on_position    (position)
#  index_images_on_product_id  (product_id)
#  index_images_on_variant_id  (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (variant_id => variants.id)
#
