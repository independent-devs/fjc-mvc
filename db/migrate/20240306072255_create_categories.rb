# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :position, null: false, default: 1

      t.timestamps
    end

    add_index :categories, :position
  end
end
