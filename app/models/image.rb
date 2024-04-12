# frozen_string_literal: true

class Image < ApplicationRecord
  include RankedModel

  # Relations
  belongs_to :product
  belongs_to :variant, optional: true
  has_one_attached :img

  # Scopes
  scope :sort_by_position, -> { rank(:sort_order) }
  scope :not_deleted, -> { where(deleted_at: nil) }

  # Position
  ranks :sort_order, column: :position, with_same: :product_id, scope: :not_deleted

  # Validations
  validate :check_image_presence

  private

  def check_image_presence
    errors.add(:img, I18n.t('images.validate.must_be_attached')) unless img.attached?
  end
end

# == Schema Information
#
# Table name: images
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  is_thumbnail :boolean          default(FALSE), not null
#  position     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_id   :bigint           not null
#  variant_id   :bigint
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
