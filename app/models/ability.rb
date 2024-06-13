# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, guest_session)
    # carts controller
    if guest_session.present? && user.blank? # Guest
      can(%i[guest_update guest_destroy], Cart, guest_session:, order: nil, user: nil)
    end

    return if user.blank? # Authenticated

    # carts controller
    if guest_session.present?
      can(:sync, Cart, guest_session:, order: nil, user: nil)
      can(:sync_all, Cart)
    end

    can(%i[update destroy], Cart, user:, order: nil)
  end
end
