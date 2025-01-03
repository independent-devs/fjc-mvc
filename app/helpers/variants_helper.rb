# frozen_string_literal: true
# typed: true

module VariantsHelper
  extend T::Sig

  sig { params(variant: Variant).returns(T::Boolean) }
  def sale?(variant)
    !variant.trackable || (variant.trackable && variant.backorderable)
  end
end
