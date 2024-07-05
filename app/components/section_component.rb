# frozen_string_literal: true
# typed: true

class SectionComponent < ViewComponent::Base
  extend T::Sig

  attr_reader :label, :title, :action_link, :action_text

  sig do
    params(
      label: String,
      title: String,
      action_link: T.nilable(String),
      action_text: String
    ).void
  end
  def initialize(label:, title:, action_link: nil, action_text: 'Show more')
    @action_link = action_link
    @action_text = action_text
    @label = label
    @title = title
    super
  end
end
