# frozen_string_literal: true

class CreateCartSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_sessions, &:timestamps
  end
end
