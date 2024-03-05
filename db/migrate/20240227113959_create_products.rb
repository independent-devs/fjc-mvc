# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.datetime :available_on, precision: nil
      t.datetime :discontinue_on, precision: nil
      t.datetime :deleted_at, precision: nil
      t.string :slug, null: false
      t.text :meta_description
      t.string :meta_keywords
      t.boolean :promotionable, null: false, default: true
      t.boolean :require_login, null: false, default: false
      t.string :meta_title
      t.decimal :lowest_price, precision: 10, scale: 2
      t.decimal :highest_price, precision: 10, scale: 2
      t.decimal :rating, precision: 1, scale: 1, default: 0

      t.timestamps
    end

    add_index :products, :slug, unique: true
    add_index :products, :name
    add_index :products, :available_on
    add_index :products, :discontinue_on
    add_index :products, :deleted_at
    add_index :products, :lowest_price
    add_index :products, :highest_price
  end
end
