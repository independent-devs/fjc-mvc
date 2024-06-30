# frozen_string_literal: true
# typed: true

class TagComponent < ViewComponent::Base
  extend T::Sig

  attr_reader :variant

  BG_COLOR = {
    primary: 'bg-primary',
    success: 'bg-green-600',
    warning: 'bg-yellow-500',
    error: 'bg-red-600'
  }.freeze

  sig { params(variant: T.any(Symbol, String)).void }
  def initialize(variant: :primary)
    @variant = variant
    super
  end

  sig { returns(String) }
  def bg_color
    BG_COLOR[variant] || BG_COLOR[:primary]
  end
end
