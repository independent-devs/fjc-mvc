# frozen_string_literal: true

class CategoryDragComponent < ViewComponent::Base
  attr_reader :is_parent, :category

  def initialize(is_parent:, category:)
    @is_parent = is_parent
    @category = category
    super
  end
end
