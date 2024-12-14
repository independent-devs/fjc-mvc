# frozen_string_literal: true

class CreateDescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :descriptions, id: :uuid do |t|
      t.text :description
      t.references :product, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
