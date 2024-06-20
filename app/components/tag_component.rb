# frozen_string_literal: true

class TagComponent < ViewComponent::Base
  attr_reader :variant

  BG_COLOR = {
    primary: 'bg-primary',
    success: 'bg-green-600',
    warning: 'bg-yellow-500',
    error: 'bg-red-600'
  }.freeze

  def initialize(variant: :primary)
    @variant = variant
    super
  end

  def bg_color
    BG_COLOR[variant] || BG_COLOR[:primary]
  end
end
