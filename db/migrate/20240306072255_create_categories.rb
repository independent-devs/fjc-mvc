# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :position, null: false, default: 1
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :categories, :position
    add_index :categories, :deleted_at
  end
end
