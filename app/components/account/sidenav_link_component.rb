# frozen_string_literal: true
# typed: true

class Account::SidenavLinkComponent < ViewComponent::Base
  extend T::Sig

  sig { params(path: String).void }
  def initialize(path:)
    @path = path
    super
  end
end
