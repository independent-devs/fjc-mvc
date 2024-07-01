# frozen_string_literal: true
# typed: true

class Ability
  extend T::Sig

  # Helpers
  include CanCan::Ability

  sig do
    params(
      user: T.nilable(User),
      guest_session: T.nilable(GuestSession),
      is_admin_path: T::Boolean
    ).void
  end
  def initialize(user, guest_session, is_admin_path: false)
    # Variant
    can :info, Variant

    # Guest Session
    guest guest_session if guest_session.present? && user.blank?

    return if user.blank?

    # Variant
    can :add_to_cart, Variant
    can :buy_now, Variant

    # Cart
    can :read, Cart, user_id: user.id, order: nil
    can :read, Cart, guest_session:, order: nil if guest_session.present?
    can %i[update destroy], Cart, user_id: user.id, order: nil

    if guest_session.present?
      can :sync, Cart, guest_session:, order: nil, user: nil
      can :sync_all, Cart
    end

    # Order
    can :read, Order, user_id: user.id
    can :cancel, Order, user_id: user.id, order_status: { name: 'pending' }

    return unless is_admin_path

    admin_permission user
  end

  private

  sig { params(guest_session: GuestSession).void }
  def guest(guest_session)
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
