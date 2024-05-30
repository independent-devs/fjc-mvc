# frozen_string_literal: true

class CreateGuestSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :guest_sessions, &:timestamps
  end
end
