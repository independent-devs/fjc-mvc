# frozen_string_literal: true

class Account::SidenavComponent < ViewComponent::Base
  delegate :current_user, to: :helpers
end
