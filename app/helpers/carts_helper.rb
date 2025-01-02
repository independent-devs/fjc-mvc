# frozen_string_literal: true
# typed: true

module CartsHelper
  extend T::Sig

  sig { params(count_on_hand: Integer, qty: Integer, sale: T::Boolean).returns(T::Boolean) }
  def checkbox_invalid?(count_on_hand, qty, sale)
    (!sale && count_on_hand.zero?) || quantity_invalid?(count_on_hand, qty, sale)
  end

  sig { params(count_on_hand: Integer, qty: Integer, sale: T::Boolean).returns(T::Boolean) }
  def quantity_invalid?(count_on_hand, qty, sale)
    !sale && count_on_hand < qty
  end
end
