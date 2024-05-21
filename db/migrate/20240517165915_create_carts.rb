# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.uuid :uuid, null: false, default: 'gen_random_uuid()'
      t.integer :qty, null: false, default: 1
      t.references :variant, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.references :order, foreign_key: true
      t.references :cart_session, foreign_key: true

      t.timestamps
    end

    add_index :carts, :uuid, unique: true
  end
end
