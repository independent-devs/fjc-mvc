# frozen_string_literal: true

class TabLinkComponent < ViewComponent::Base
  attr_reader :path

  def initialize(path:)
    @path = path
    super
  end
end
