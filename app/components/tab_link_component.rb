# frozen_string_literal: true
# typed: true

class TabLinkComponent < ViewComponent::Base
  extend T::Sig

  attr_reader :path, :target

  sig { params(path: String, target: T.nilable(String)).void }
  def initialize(path:, target: nil)
    @path = path
    @target = target
    super
  end
end
