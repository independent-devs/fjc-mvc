# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, guest_session)
    can :index, Cart

    guest(guest_session) if guest_session.present? && user.blank?

    return if user.blank?

    if guest_session.present?
      can(:sync, Cart, guest_session:, order: nil, user: nil)
      can(:sync_all, Cart)
    end

    can(%i[update destroy], Cart, user:, order: nil)
  end

  private

  def guest(guest_session)
    can(%i[update destroy], Cart, guest_session:, order: nil, user: nil)
  end
end
