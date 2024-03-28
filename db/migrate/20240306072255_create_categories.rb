# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :position
      t.datetime :deleted_at
      t.string :ancestry

      t.timestamps
    end

    add_index :categories, :position
    add_index :categories, :deleted_at
    add_index :categories, :ancestry
    add_index :categories, %i[name ancestry], unique: true
  end
end
