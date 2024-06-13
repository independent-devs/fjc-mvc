# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, guest_session)
    if guest_session.present?
      # carts controller
      can(:guest_update, Cart, guest_session:, order: nil) if user.blank?
      can(:guest_destroy, Cart, guest_session:)
    end

    return if user.blank?

    # carts controller
    can(:update, Cart, user:, order: nil)
    can(:destroy, Cart, user:)
    can(:sync, Cart, user: nil, guest_session:, order: nil)
    can(:sync_all, Cart) if guest_session.present?

    # return unless user.admin?
    #
    # can :manage, :all

    # rThe frrst argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
