# frozen_string_literal: true

class StockCountComponent < ViewComponent::Base
  attr_reader :count

  def initialize(count:)
    @count = count
    super
  end
end
