# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, guest_session)
    guest(guest_session) if guest_session.present? && user.blank?

    return if user.blank?

    # Cart
    can(:read, Cart, user_id: user.id, order: nil)
    can(:read, Cart, guest_session:, order: nil) if guest_session.present?
    can(%i[update destroy], Cart, user_id: user.id, order: nil)

    if guest_session.present?
      can(:sync, Cart, guest_session:, order: nil, user: nil)
      can(:sync_all, Cart)
    end

    # Order
    can(:read, Order, user_id: user.id)
    can(:cancel, Order, user_id: user.id, order_status: { name: 'pending' })
  end

  private

  def guest(guest_session)
    # Cart
    can(:read, Cart, guest_session:, user: nil, order: nil)
    can(%i[update destroy], Cart, guest_session:, user: nil, order: nil)

    # Order
    can(:read, Order, guest_session:, user: nil)
    can(:cancel, Order, guest_session:, user: nil, order_status: { name: 'pending' })
  end
end
