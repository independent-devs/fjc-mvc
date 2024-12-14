# frozen_string_literal: true
# typed: true

class GuestSession < ApplicationRecord
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :nullify
end

# == Schema Information
#
# Table name: guest_sessions
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
