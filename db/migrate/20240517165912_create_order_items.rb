# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items, id: :uuid do |t|
      t.references :order, foreign_key: true, type: :uuid
      t.references :variant, foreign_key: true, type: :uuid
      t.decimal :price, null: false, precision: 10, scale: 2
      t.integer :qty, null: false, default: 1
      t.integer :discount_percent, null: false, default: 0

      t.timestamps
    end
  end
end
