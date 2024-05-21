# frozen_string_literal: true

class CartSession < ApplicationRecord
  has_many :carts, dependent: :destroy
end

# == Schema Information
#
# Table name: cart_sessions
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
