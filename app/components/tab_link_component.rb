# frozen_string_literal: true
# typed: true

class TabLinkComponent < ViewComponent::Base
  extend T::Sig

  attr_reader :path

  sig { params(path: String).void }
  def initialize(path:)
    @path = path
    super
  end
end
