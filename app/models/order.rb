# frozen_string_literal: true
# typed: true

class Order < ApplicationRecord
  # Relations
  belongs_to :order_status
  belongs_to :user, optional: true
  belongs_to :guest_session, optional: true
  belongs_to :payment_method, optional: true

  has_one :shipping_detail, as: :shippable, dependent: :destroy
  has_many :order_items, dependent: :nullify

  accepts_nested_attributes_for :shipping_detail

  # Scopes
  scope :with_status, -> { select('orders.*, order_statuses.name AS status').joins(:order_status) }
  scope :sort_by_latest, -> { order(created_at: :desc) }

  # Validations
  validates :guest_session, presence: true, unless: :user
  validates :user, presence: true, unless: :guest_session
  validates :shipping_detail, presence: true, if: :placed_at
  validates :payment_method, presence: true, if: :placed_at

  validate :validate_ownership

  def self.checkout(carts, parent)
    Order.transaction do
      order = Order.build
      order.guest_session = parent if parent.instance_of?(GuestSession)
      order.user = parent if parent.instance_of?(User)
      order.order_status = OrderStatus.find_by(name: 'pending')
      order.save!

      carts.each do |cart|
        order.order_items.create!(variant: cart.variant, qty: cart.qty, price: cart.variant.price)
        cart.destroy
      end

      order
    rescue StandardError => e
      logger.warn e
      nil
    end
  end

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
#  id                :uuid             not null, primary key
#  internal_note     :text
#  logistic_ref      :string
#  logistic_url      :string
#  placed_at         :datetime
#  refund_reason     :text
#  return_reason     :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  guest_session_id  :uuid
#  order_status_id   :uuid             not null
#  payment_method_id :uuid
#  user_id           :uuid
#
# Indexes
#
#  index_orders_on_guest_session_id   (guest_session_id)
#  index_orders_on_order_status_id    (order_status_id)
#  index_orders_on_payment_method_id  (payment_method_id)
#  index_orders_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_session_id => guest_sessions.id)
#  fk_rails_...  (order_status_id => order_statuses.id)
#  fk_rails_...  (payment_method_id => payment_methods.id)
#  fk_rails_...  (user_id => users.id)
#
