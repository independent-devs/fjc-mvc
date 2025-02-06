# frozen_string_literal: true

class CreateVariantOptionValues < ActiveRecord::Migration[7.0]
  def change
    create_table :variant_option_values, id: :uuid do |t|
      t.string :name, null: false
      t.string :illustration, null: false, default: ''
      t.references :variant, null: false, foreign_key: true, type: :uuid
      t.references :product_option, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :variant_option_values, :name
    add_index :variant_option_values, %i[variant_id product_option_id], unique: true
  end
end
