# frozen_string_literal: true

class CreateProductOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :product_options do |t|
      t.references :product, null: false, foreign_key: true
      t.references :option, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
