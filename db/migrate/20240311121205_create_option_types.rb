# frozen_string_literal: true

class CreateOptionTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :option_types do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :option_types, :deleted_at
  end
end
