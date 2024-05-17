# frozen_string_literal: true

class CreateOrderStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :order_statuses do |t|
      t.string :name, null: false
      t.integer :step, null: false

      t.timestamps
    end

    add_index :order_statuses, :name, unique: true
    add_index :order_statuses, :step, unique: true
  end
end
