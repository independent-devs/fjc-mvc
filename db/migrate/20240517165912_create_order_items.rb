# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :variant, null: false, foreign_key: true
      t.integer :qty, null: false, default: 1
      t.decimal :price, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
