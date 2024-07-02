# frozen_string_literal: true
# typed: true

class Account::SidenavUserComponent < ViewComponent::Base
  extend T::Sig

  sig { params(user: T.nilable(User)).void }
  def initialize(user:)
    @user = user
    super
  end
end
