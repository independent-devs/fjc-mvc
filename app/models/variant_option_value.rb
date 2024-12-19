# frozen_string_literal: true
# typed: true

class VariantOptionValue < ApplicationRecord
  # Concerns
  include ActiveStorage::Attached::Model

  # Relations
  belongs_to :variant
  belongs_to :product_option

  # Attachments
  has_one_attached :image do |attachable|
    attachable.variant :small, resize_to_limit: [150, 150]
  end

  # Filter
  normalizes :name, with: -> { _1.strip }

  # Scopes
  scope :grouped_names, -> { select('name').group(:name) }
  scope :with_variant_position,
        lambda {
          select('variant_option_values.*')
            .select('variants.position, variants.id as variant_id')
            .joins(:variant)
            .order('variants.position ASC')
        }

  # Validations
  validates :name, presence: true
end

# == Schema Information
#
# Table name: variant_option_values
#
#  id                :uuid             not null, primary key
#  name              :string           not null
#  value             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  product_option_id :uuid             not null
#  variant_id        :uuid             not null
#
# Indexes
#
#  index_variant_option_values_on_name                              (name)
#  index_variant_option_values_on_product_option_id                 (product_option_id)
#  index_variant_option_values_on_variant_id                        (variant_id)
#  index_variant_option_values_on_variant_id_and_product_option_id  (variant_id,product_option_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (product_option_id => product_options.id)
#  fk_rails_...  (variant_id => variants.id)
#
