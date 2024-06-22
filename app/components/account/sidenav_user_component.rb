# frozen_string_literal: true

class Account::SidenavUserComponent < ViewComponent::Base
  def initialize(user:, signed_in: false)
    @user = user
    @signed_in = signed_in
    super
  end
end
