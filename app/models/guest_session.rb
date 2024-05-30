# frozen_string_literal: true

class GuestSession < ApplicationRecord
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy
end

# == Schema Information
#
# Table name: guest_sessions
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
