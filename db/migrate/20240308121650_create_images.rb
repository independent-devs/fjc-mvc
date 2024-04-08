# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.references :product, null: false, foreign_key: true
      t.references :variant, foreign_key: true
      t.boolean :is_thumbnail, null: false, default: false
      t.integer :position
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :images, :position
    add_index :images, :deleted_at
  end
end
