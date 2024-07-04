# frozen_string_literal: true
# typed: true

class Carts::Item::CartStockWarningComponent < ViewComponent::Base
  extend T::Sig

  delegate :quantity_invalid?, to: :helpers
  attr_reader :uuid, :count_on_hand, :qty, :backorderable

  sig { params(uuid: String, count_on_hand: Integer, qty: Integer, backorderable: T::Boolean).void }
  def initialize(uuid:, count_on_hand:, qty:, backorderable:)
    @count_on_hand = count_on_hand
    @backorderable = backorderable
    @qty = qty
    @uuid = uuid
    super
  end
end
