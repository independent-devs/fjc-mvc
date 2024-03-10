# frozen_string_literal: true

class Image < ApplicationRecord
  has_one_attached :photo

  belongs_to :product
  belongs_to :variant
end

# == Schema Information
#
# Table name: images
#
#  id         :bigint           not null, primary key
#  position   :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  variant_id :bigint
#
# Indexes
#
#  index_images_on_product_id               (product_id)
#  index_images_on_product_id_and_position  (product_id,position)
#  index_images_on_variant_id               (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (variant_id => variants.id)
#
