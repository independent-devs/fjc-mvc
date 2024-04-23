# frozen_string_literal: true

class TagComponent < ViewComponent::Base
  attr_reader :name, :variant

  BG_COLOR = {
    primary: 'bg-primary',
    success: 'bg-green-600',
    warning: 'bg-yellow-600',
    error: 'bg-red-600'
  }.freeze

  def initialize(name:, variant: :primary)
    @name = name
    @variant = variant
    super
  end

  def bg_color
    BG_COLOR[variant] || BG_COLOR[:primary]
  end
end
