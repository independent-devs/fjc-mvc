# frozen_string_literal: true

class Account::SidenavLinkComponent < ViewComponent::Base
  def initialize(path:)
    @path = path
    super
  end
end
