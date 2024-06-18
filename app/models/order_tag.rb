# frozen_string_literal: true

class OrderTag < ApplicationRecord
  # Constants
  UNFULFILLED_TAGS = %w[cancelled returned refunded].freeze

  # Relations
  belongs_to :order_status
  has_many :order_status_tags, dependent: :destroy

  # Validations
  validates :name, uniqueness: true, presence: true
  validate :order_must_unfulfilled

  private

  def order_must_unfulfilled
    return unless name.in?(UNFULFILLED_TAGS) && order_status.name != 'unfulfilled'

    errors.add(:order_status, 'must be unfulfilled.')
  end
end

# == Schema Information
#
# Table name: order_tags
#
#  id              :bigint           not null, primary key
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_status_id :bigint           not null
#
# Indexes
#
#  index_order_tags_on_name             (name) UNIQUE
#  index_order_tags_on_order_status_id  (order_status_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_status_id => order_statuses.id)
#
