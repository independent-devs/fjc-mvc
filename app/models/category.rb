# frozen_string_literal: true

class Category < ApplicationRecord
  include RankedModel

  # Relations
  belongs_to :base, class_name: 'Category', optional: true
  belongs_to :from, class_name: 'Category', optional: true
  has_many :froms, class_name: 'Category', foreign_key: :from_id, dependent: :destroy, inverse_of: :base
  has_many :product_categories, dependent: :destroy

  # Scopes
  scope :not_deleted, -> { where(deleted_at: nil) }

  # Position
  ranks :sort_order, column: :position, with_same: :from_id, scope: :not_deleted

  # Validations
  validates :name, presence: true
end

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string           not null
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  base_id    :bigint
#  from_id    :bigint
#
# Indexes
#
#  index_categories_on_base_id     (base_id)
#  index_categories_on_deleted_at  (deleted_at)
#  index_categories_on_from_id     (from_id)
#  index_categories_on_position    (position)
#
# Foreign Keys
#
#  fk_rails_...  (base_id => categories.id)
#  fk_rails_...  (from_id => categories.id)
#
