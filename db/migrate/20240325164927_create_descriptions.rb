# frozen_string_literal: true

class CreateDescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :descriptions do |t|
      t.text :description
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
