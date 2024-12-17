# frozen_string_literal: true
# typed: true

class Ability
  extend T::Sig

  # Helpers
  include CanCan::Ability

  sig { params(user: T.nilable(User), guest_session: T.nilable(GuestSession)).void }
  def initialize(user, guest_session: nil)
    # public
    can :info, Variant
    can :variant_dropdown, Cart
    can :read, Product

    # Guest Session
    guest_permission guest_session if guest_session.present? && user.blank?

    return if user.blank?

    # Variant
    can :add_to_cart, Variant
    can :buy_now, Variant

    # Cart
    can(:read, Cart, user:)
    can(:read, Cart, guest_session:) if guest_session.present?
    can %i[update destroy], Cart, user:, guest_session: nil

    if guest_session.present?
      can(:sync, Cart, guest_session:)
      can(:sync_all, Cart)
    end

    # Order
    can(:read, Order, user:)
    can(:cancel, Order, user:, order_status: { name: 'pending' })
  end

  private

  sig { params(guest_session: GuestSession).void }
  def guest_permission(guest_session)
    # Variant
    can :guest_add_to_cart, Variant
    can :guest_buy_now, Variant

    # Cart
    can(:read, Cart, guest_session:)
    can(%i[update destroy], Cart, guest_session:)

    # Order
    can(:read, Order, guest_session:)
    can(:cancel, Order, guest_session:, order_status: { name: 'pending' })
  end
end
