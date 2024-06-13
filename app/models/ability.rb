# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, guest_session)
    if guest_session.present? # Guest
      # carts controller
      can(:guest_update, Cart, guest_session:, order: nil) if user.blank?
      can(:guest_destroy, Cart, guest_session:)
    end

    return if user.blank? # Authenticated

    # carts controller
    can(:update, Cart, user:, order: nil)
    can(:destroy, Cart, user:)
    can(:sync, Cart, user: nil, guest_session:, order: nil)
    can(:sync_all, Cart) if guest_session.present?
  end
end
