# frozen_string_literal: true

class TabComponent < ViewComponent::Base
  attr_reader :name, :path

  def initialize(name:, path:)
    @name = name
    @path = path
    super
  end
end
