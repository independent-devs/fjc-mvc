# frozen_string_literal: true
# typed: true

class StockCountComponent < ViewComponent::Base
  extend T::Sig

  attr_reader :count, :display_oos, :sale

  sig { params(count: Integer, display_oos: T::Boolean, sale: T::Boolean).void }
  def initialize(count:, display_oos: true, sale: false)
    @count = count
    @display_oos = display_oos
    @sale = sale
    super
  end
end
