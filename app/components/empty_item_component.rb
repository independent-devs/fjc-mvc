# frozen_string_literal: true
# typed: true

class EmptyItemComponent < ViewComponent::Base
  extend T::Sig

  sig { params(text: String, id: String, hide: T::Boolean).void }
  def initialize(text:, id: 'items-empty', hide: false)
    @id = id
    @text = text
    @hide = hide
    super
  end
end
