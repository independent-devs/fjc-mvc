# frozen_string_literal: true

class CreateProductCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :product_categories do |t|
      t.references :product, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.boolean :is_master, null: false, default: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :product_categories, %i[product_id category_id], unique: true
    add_index :product_categories, :deleted_at
  end
end
