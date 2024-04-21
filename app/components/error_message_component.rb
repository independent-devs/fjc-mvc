# frozen_string_literal: true

class ErrorMessageComponent < ViewComponent::Base
  attr_reader :errors, :label

  def initialize(errors: [], label: 'errors')
    @errors = errors
    @label = label
    super
  end
end
