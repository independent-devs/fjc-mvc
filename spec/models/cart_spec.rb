# frozen_string_literal: true

# require 'rails_helper'
#
# RSpec.describe Cart, type: :model do
#   it 'Guest cart without user' do
#     cart = build(:cart, :guest_cart)
#
#     expect(cart).to be_valid
#     expect(cart.user).to eq(nil)
#     expect(cart.variant).to be_present
#     expect(cart.guest_session).to be_present
#     expect(cart.order).to eq(nil)
#   end
#
#   it 'User cart not synced with guest' do
#     cart = build(:cart, :user_cart)
#
#     expect(cart).to be_valid
#     expect(cart.user).to be_present
#     expect(cart.variant).to be_present
#     expect(cart.guest_session).to eq(nil)
#     expect(cart.order).to eq(nil)
#   end
#
#   it 'User cart synced with guest' do
#     cart = build(:cart, :user_cart_synced)
#
#     expect(cart).to be_valid
#     expect(cart.user).to be_present
#     expect(cart.variant).to be_present
#     expect(cart.guest_session).to be_present
#     expect(cart.order).to eq(nil)
#   end
#
#   it 'User ordered cart not synced with guest' do
#     cart = build(:cart, :user_order)
#
#     expect(cart).to be_valid
#     expect(cart.user).to be_present
#     expect(cart.variant).to be_present
#     expect(cart.guest_session).to eq(nil)
#     expect(cart.order).to be_present
#   end
#
#   it 'User ordered cart synced with guest' do
#     cart = build(:cart)
#
#     expect(cart).to be_valid
#     expect(cart.user).to be_present
#     expect(cart.variant).to be_present
#     expect(cart.guest_session).to be_present
#     expect(cart.order).to be_present
#   end
#
#   it 'Cart should have a parent/owned' do
#     cart = build(:cart, :not_owned)
#
#     expect(cart).not_to be_valid
#   end
# end

# == Schema Information
#
# Table name: carts
#
#  id               :uuid             not null, primary key
#  qty              :integer          default(1), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  guest_session_id :uuid
#  user_id          :uuid
#  variant_id       :uuid             not null
#
# Indexes
#
#  index_carts_on_guest_session_id  (guest_session_id)
#  index_carts_on_user_id           (user_id)
#  index_carts_on_variant_id        (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_session_id => guest_sessions.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (variant_id => variants.id)
#
