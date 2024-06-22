# frozen_string_literal: true

class Account::SidenavComponent < ViewComponent::Base
  delegate :current_user, :user_signed_in?, to: :helpers
end
