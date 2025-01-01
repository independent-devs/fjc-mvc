# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false
      t.date :available_on, precision: nil
      t.date :discontinue_on, precision: nil
      t.boolean :promotable, null: false, default: true
      t.boolean :order_must_login, null: false, default: false
      t.decimal :lowest_price, precision: 10, scale: 2
      t.decimal :highest_price, precision: 10, scale: 2
      t.string :currency, null: false
      t.decimal :review_avg_rating, precision: 1, scale: 1, default: 0
      t.integer :review_count, default: 0
      t.boolean :has_variant, null: false, default: false

      t.timestamps
    end

    add_index :products, :name
    add_index :products, :available_on
    add_index :products, :discontinue_on
    add_index :products, :lowest_price
    add_index :products, :highest_price
  end
end
