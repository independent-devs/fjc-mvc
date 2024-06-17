# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, guest_session)
    guest(guest_session) if guest_session.present? && user.blank?

    return if user.blank?

    # Cart
    can(:index, Cart, user:, order: nil)
    can(:index, Cart, guest_session:, order: nil) if guest_session.present?
    can(%i[update destroy], Cart, user:, order: nil)

    if guest_session.present?
      can(:sync, Cart, guest_session:, order: nil, user: nil)
      can(:sync_all, Cart)
    end

    # Order
    can(:read, Order, user:)
    can(:cancel, Order, user:)
  end

  private

  def guest(guest_session)
    # Cart
    can(:index, Cart, guest_session:, user: nil, order: nil)
    can(%i[update destroy], Cart, guest_session:, user: nil, order: nil)

    # Order
    can(:read, Order, guest_session:, user: nil)
    can(:cancel, Order, guest_session:, user: nil)
  end
end
