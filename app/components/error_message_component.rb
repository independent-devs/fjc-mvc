# frozen_string_literal: true
# typed: true

class ErrorMessageComponent < ViewComponent::Base
  extend T::Sig

  attr_reader :errors, :label

  sig { params(errors: T::Array[String], label: String).void }
  def initialize(errors: [], label: 'errors')
    @errors = errors
    @label = label
    super
  end
end
