# frozen_string_literal: true
# typed: true

class Ability
  extend T::Sig

  # Helpers
  include CanCan::Ability

  sig { params(user: T.nilable(User), guest_session: T.nilable(GuestSession), portal: Integer).void }
  def initialize(user, guest_session: nil, portal: Portal::STOREFRONT)
    storefront_permission(guest_session, user) if storefront_portal?(portal)
    admin_permission(user) if admin_portal?(portal)
  end

  private

  sig { params(guest_session: T.nilable(GuestSession), user: T.nilable(User)).void }
  def storefront_permission(guest_session, user)
    # public
    can :info, Variant
    can :variant_dropdown, Cart
    can :read, Product

    # Guest permission
    guest_permission(guest_session) if guest_session.present? && user.blank?

    return if user.blank?

    # Variant
    can :add_to_cart, Variant
    can :buy_now, Variant

    # Cart
    can(%i[read update destroy], Cart, user:)
    can(%i[read sync destroy sync_all], Cart, guest_session:) if guest_session.present?

    # Order
    can(:read, Order, user:)
    can(:cancel, Order, user:, order_status: { name: 'pending' })
  end

  sig { params(user: T.nilable(User)).void }
  def admin_permission(user)
    return unless user&.admin?

    can :manage, Product
    can :manage, Variant
    can :manage, Order
    can :manage, Category
    can :manage, Option
  end

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

  sig { params(portal: Integer).returns(T::Boolean) }
  def storefront_portal?(portal)
    portal == Portal::STOREFRONT
  end

  sig { params(portal: Integer).returns(T::Boolean) }
  def admin_portal?(portal)
    portal == Portal::ADMIN
  end
end
