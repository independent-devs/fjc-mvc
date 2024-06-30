# frozen_string_literal: true
# typed: true

class SectionComponent < ViewComponent::Base
  extend T::Sig

  attr_reader :label, :title, :action_partial

  sig { params(label: String, title: String, action_partial: String).void }
  def initialize(label:, title:, action_partial: '')
    @label = label
    @title = title
    @action_partial = action_partial
    super
  end
end
