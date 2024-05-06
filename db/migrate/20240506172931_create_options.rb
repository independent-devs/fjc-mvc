# frozen_string_literal: true

class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
