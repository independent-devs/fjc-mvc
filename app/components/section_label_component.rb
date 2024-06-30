# frozen_string_literal: true
# typed: true

class SectionLabelComponent < ViewComponent::Base
  extend T::Sig
  attr_reader :label

  sig { params(label: String).void }
  def initialize(label:)
    @label = label
    super
  end
end
