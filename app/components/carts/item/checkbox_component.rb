# frozen_string_literal: true
# typed: true

class Carts::Item::CheckboxComponent < ViewComponent::Base
  extend T::Sig

  attr_reader :uuid, :invalid

  sig { params(uuid: String, invalid: T::Boolean).void }
  def initialize(uuid:, invalid: false)
    @uuid = uuid
    @invalid = invalid
    super
  end
end
