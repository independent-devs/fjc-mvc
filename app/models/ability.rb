# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, guest_session)
    if guest_session.present? # Guest
      # carts controller
      can(:guest_update, Cart, guest_session:, order: nil, user: nil) if user.blank?
      can(:guest_destroy, Cart, guest_session:, order: nil)
    end

    return if user.blank? # Authenticated

    # carts controller
    if guest_session.present?
      can(:sync, Cart, guest_session:, order: nil, user: nil)
      can(:sync_all, Cart)
    end

    can(:update, Cart, user:, order: nil)
    can(:destroy, Cart, user:)
  end
end
