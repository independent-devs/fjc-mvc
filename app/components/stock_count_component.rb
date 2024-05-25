# frozen_string_literal: true

class StockCountComponent < ViewComponent::Base
  attr_reader :count, :display_oos

  def initialize(count:, display_oos: true)
    @count = count
    @display_oos = display_oos
    super
  end
end
