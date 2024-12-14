# frozen_string_literal: true
# typed: true

class Ability
  extend T::Sig

  # Helpers
  include CanCan::Ability

  sig { params(user: T.nilable(User), guest_session: T.nilable(GuestSession), is_admin_path: T::Boolean).void }
  def initialize(user, guest_session, is_admin_path: false)
    # Admin permission
    if is_admin_path && user.present?
      admin_permission user
      return
    end

    # Variant
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
    can :read, Cart, user:, order: nil
    can :read, Cart, guest_session:, order: nil if guest_session.present?
    can %i[update destroy], Cart, user:, order: nil

    if guest_session.present?
      can :sync, Cart, guest_session:, order: nil, user: nil
      can :sync_all, Cart
    end

    # Order
    can(:read, Order, user:)
    can :cancel, Order, user:, order_status: { name: 'pending' }
  end

  private

  sig { params(guest_session: GuestSession).void }
  def guest_permission(guest_session)
    # Variant
    can :guest_add_to_cart, Variant
    can :guest_buy_now, Variant

    # Cart
    can :read, Cart, guest_session:, user: nil, order: nil
    can %i[update destroy], Cart, guest_session:, user: nil, order: nil

    # Order
    can :read, Order, guest_session:, user: nil
    can :cancel, Order, guest_session:, user: nil, order_status: { name: 'pending' }
  end

  sig { params(user: User).void }
  def admin_permission(user)
    return unless user.admin?

    # special permission here
    Rails.logger.info user.to_json
  end
end
