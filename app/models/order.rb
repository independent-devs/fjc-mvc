# frozen_string_literal: true
# typed: true

class Order < ApplicationRecord
  # Relations
  belongs_to :order_status
  belongs_to :user, optional: true
  belongs_to :guest_session, optional: true

  has_many :order_items, dependent: :nullify

  # Scopes
  scope :with_status, -> { select('orders.*, order_statuses.name AS status').joins(:order_status) }

  # Validations
  validates :guest_session, presence: true, unless: :user
  validates :user, presence: true, unless: :guest_session

  validate :validate_ownership

  private

  def validate_ownership
    return unless user_id.present? && guest_session_id.present?

    errors.add(:ownership, I18n.t('orders.validate.ownership_cant_be_both'))
  end
end

# == Schema Information
#
# Table name: orders
#
#  id               :uuid             not null, primary key
#  tag              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  guest_session_id :uuid
#  order_status_id  :uuid             not null
#  user_id          :uuid
#
# Indexes
#
#  index_orders_on_guest_session_id  (guest_session_id)
#  index_orders_on_order_status_id   (order_status_id)
#  index_orders_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_session_id => guest_sessions.id)
#  fk_rails_...  (order_status_id => order_statuses.id)
#  fk_rails_...  (user_id => users.id)
#
