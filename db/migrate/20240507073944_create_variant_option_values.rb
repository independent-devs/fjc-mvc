# frozen_string_literal: true

class CreateVariantOptionValues < ActiveRecord::Migration[7.0]
  def change
    create_table :variant_option_values, id: :uuid do |t|
      t.references :variant, null: false, foreign_key: true, type: :uuid
      t.references :product_option, null: false, foreign_key: true, type: :uuid
      t.integer :position
      t.string :name, null: false

      t.timestamps
    end
  end
end
