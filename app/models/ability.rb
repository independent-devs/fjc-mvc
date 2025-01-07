# frozen_string_literal: true
# typed: true

class Ability
  extend T::Sig

  # Concerns
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
    can :read, Product
    can :info, Variant
    can :variant_dropdown, Cart

    # Guest permission
    guest_permission(guest_session) if guest_session.present? && user.blank?

    return if user.blank?

    # Variant
    can %i[add_to_cart buy_now], Variant

    # Cart
    can(%i[index update destroy], Cart, user:)
    can(%i[index sync destroy sync_all], Cart, guest_session:) if guest_session.present?
    can(%i[proceed_checkout total bulk_delete count], Cart, Cart.checkout_condition.where(user:)) do |cart|
      ((cart.variant.trackable && cart.variant.count_on_hand.positive? && cart.qty <= cart.variant.count_on_hand) ||
        (!cart.variant.trackable || (cart.variant.trackable && cart.variant.backorderable))) &&
        cart.user.present? && cart.user = user
    end

    # Order
    can(:read, Order, user:)
    can(:cancel, Order, user:, order_status: { name: 'pending' })
  end

  sig { params(user: T.nilable(User)).void }
  def admin_permission(user)
    return unless user&.admin?

    can :manage, Product
    can :manage, Variant, is_master: false, product: { has_variant: true }
    can :manage, :image
    can :manage, :stock

    can :manage, Order
    can :manage, Category
    can :manage, Option
    can :manage, User
  end

  sig { params(guest_session: GuestSession).void }
  def guest_permission(guest_session)
    # Variant
    can %i[guest_add_to_cart guest_buy_now], Variant

    # Cart
    can(%i[index update destroy], Cart, guest_session:)
    can(%i[proceed_checkout total bulk_delete count], Cart, Cart.checkout_condition.where(guest_session:)) do |cart|
      ((cart.variant.trackable && cart.variant.count_on_hand.positive? && cart.qty <= cart.variant.count_on_hand) ||
      (!cart.variant.trackable || (cart.variant.trackable && cart.variant.backorderable))) &&
        cart.guest_session.present? && cart.guest_session = guest_session
    end

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
