# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.references :variant, null: false, foreign_key: true
      t.integer :qty, null: false, default: 1

      t.timestamps
    end
  end
end
