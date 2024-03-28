# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :position
      t.datetime :deleted_at
      t.references :from, foreign_key: { to_table: :categories }
      t.references :base, foreign_key: { to_table: :categories }

      t.timestamps
    end

    add_index :categories, :position
    add_index :categories, :deleted_at
  end
end
