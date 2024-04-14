# frozen_string_literal: true

class CreateVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :variants do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.string :sku
      t.integer :position
      t.datetime :deleted_at
      t.decimal :cost, precision: 10, scale: 2
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :count_on_hand, default: 0
      t.boolean :is_master, null: false, default: false
      t.boolean :trackable, null: false, default: true

      t.timestamps
    end

    add_index :variants, :position
    add_index :variants, :deleted_at
    add_index :variants, :sku
  end
end
