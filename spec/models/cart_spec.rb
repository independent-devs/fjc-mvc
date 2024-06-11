# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  it 'Guest cart without user' do
    cart = create(:cart, :guest_cart)

    expect(cart.user).to eq(nil)
    expect(cart.variant).to be_present
    expect(cart.guest_session).to be_present
    expect(cart.order).to eq(nil)
  end

  it 'User cart not synced with guest' do
    cart = create(:cart, :user_cart)

    expect(cart.user).to be_present
    expect(cart.variant).to be_present
    expect(cart.guest_session).to eq(nil)
    expect(cart.order).to eq(nil)
  end

  it 'User cart synced with guest' do
    cart = create(:cart, :user_cart_synced)

    expect(cart.user).to be_present
    expect(cart.variant).to be_present
    expect(cart.guest_session).to be_present
    expect(cart.order).to eq(nil)
  end

  it 'User ordered cart not synced with guest' do
    cart = create(:cart, :user_order)

    expect(cart.user).to be_present
    expect(cart.variant).to be_present
    expect(cart.guest_session).to eq(nil)
    expect(cart.order).to be_present
  end

  it 'User ordered cart synced with guest' do
    cart = create(:cart)

    expect(cart.user).to be_present
    expect(cart.variant).to be_present
    expect(cart.guest_session).to be_present
    expect(cart.order).to be_present
  end

  it 'Invalid Cart' do
    cart = build(:cart, :invalid_check)

    expect(cart).not_to be_valid
  end
end

# == Schema Information
#
# Table name: carts
#
#  id               :bigint           not null, primary key
#  qty              :integer          default(1), not null
#  uuid             :uuid             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  guest_session_id :bigint
#  order_id         :bigint
#  user_id          :bigint
#  variant_id       :bigint           not null
#
# Indexes
#
#  index_carts_on_guest_session_id  (guest_session_id)
#  index_carts_on_order_id          (order_id)
#  index_carts_on_user_id           (user_id)
#  index_carts_on_uuid              (uuid) UNIQUE
#  index_carts_on_variant_id        (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_session_id => guest_sessions.id)
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (variant_id => variants.id)
#
