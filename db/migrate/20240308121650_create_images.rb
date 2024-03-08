# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.references :product, null: false, foreign_key: true
      t.references :variant, null: true, foreign_key: true
      t.integer :position, null: false, default: true

      t.timestamps
    end

    add_index :images, %i[product_id position], unique: true
  end
end
