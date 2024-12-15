# frozen_string_literal: true
# typed: true

class ProductOption < ApplicationRecord
  include RankedModel

  # Relations
  belongs_to :product
  belongs_to :option
  has_many :variant_option_values, dependent: :destroy

  # Scopes
  scope :sort_by_position, -> { rank(:sort_order) }
  scope :with_option_columns,
        lambda {
          select('product_options.*, options.name, options.display_name, options.placeholder')
            .joins(:option)
        }

  # Position
  ranks :sort_order, column: :position

  # Generators
  before_create :variant_cleanup
  before_destroy :variant_cleanup, prepend: true

  private

  def remove_variants
    product.variants.not_master.destroy_all
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
