# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :order_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
