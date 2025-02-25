# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name, null: false
      t.string :ancestry
      t.integer :ancestry_depth, default: 0

      t.timestamps
    end

    add_index :categories, :ancestry
    add_index :categories, %i[name ancestry], unique: true
  end
end
