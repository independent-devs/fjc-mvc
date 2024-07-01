# frozen_string_literal: true
# typed: true

class Account::SidenavUserComponent < ViewComponent::Base
  extend T::Sig

  sig { params(user: User, signed_in: T::Boolean).void }
  def initialize(user:, signed_in: false)
    @user = user
    @signed_in = signed_in
    super
  end
end
