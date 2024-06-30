# frozen_string_literal: true
# typed: true

class StockCountComponent < ViewComponent::Base
  extend T::Sig
  attr_reader :count, :display_oos

  sig { params(count: Integer, display_oos: T::Boolean).void }
  def initialize(count:, display_oos: true)
    @count = count
    @display_oos = display_oos
    super
  end
end
