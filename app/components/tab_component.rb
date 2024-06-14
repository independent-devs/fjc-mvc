# frozen_string_literal: true

class TabComponent < ViewComponent::Base
  attr_reader :path

  def initialize(path:)
    @path = path
    super
  end
end
