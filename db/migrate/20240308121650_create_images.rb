# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.references :product, null: false, foreign_key: true
      t.references :variant, foreign_key: true
      t.integer :position, null: false, default: 1

      t.timestamps
    end

    add_index :images, %i[product_id position]
  end
end
