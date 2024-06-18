# frozen_string_literal: true

class CreateOrderTags < ActiveRecord::Migration[7.0]
  def change
    create_table :order_tags do |t|
      t.string :name, null: false
      t.references :order_status, null: false, foreign_key: true

      t.timestamps
    end

    add_index :order_tags, :name, unique: true
  end
end
