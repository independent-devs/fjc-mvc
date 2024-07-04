# frozen_string_literal: true
# typed: true

module CartsHelper
  extend T::Sig

  sig { params(count_on_hand: Integer, qty: Integer, backorderable: T::Boolean).returns(T::Boolean) }
  def checkbox_invalid?(count_on_hand, qty, backorderable)
    (!backorderable && count_on_hand.zero?) || quantity_invalid?(count_on_hand, qty, backorderable)
  end

  sig { params(count_on_hand: Integer, qty: Integer, backorderable: T::Boolean).returns(T::Boolean) }
  def quantity_invalid?(count_on_hand, qty, backorderable)
    !backorderable && count_on_hand < qty
  end
end
