# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.uuid :uuid, null: false, default: 'gen_random_uuid()'
      t.string :name, null: false
      t.datetime :available_on, precision: nil
      t.datetime :discontinue_on, precision: nil
      t.datetime :deleted_at, precision: nil
      t.string :slug, null: false
      t.boolean :promotable, null: false, default: true
      t.boolean :order_must_login, null: false, default: false
      t.decimal :lowest_price, precision: 10, scale: 2
      t.decimal :highest_price, precision: 10, scale: 2
      t.string :currency, null: false
      t.decimal :rating, precision: 1, scale: 1, default: 0
      t.integer :rate_count, default: 0
      t.boolean :has_variant, null: false, default: false
      t.string :variant_label, null: false, default: 'Variations'

      t.timestamps
    end

    add_index :products, :uuid, unique: true
    add_index :products, :slug
    add_index :products, :name
    add_index :products, :available_on
    add_index :products, :discontinue_on
    add_index :products, :deleted_at
    add_index :products, :lowest_price
    add_index :products, :highest_price
  end
end
