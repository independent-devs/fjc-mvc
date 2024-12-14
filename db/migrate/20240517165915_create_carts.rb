# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts, id: :uuid do |t|
      t.integer :qty, null: false, default: 1
      t.references :variant, null: false, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
      t.references :order, foreign_key: true, type: :uuid
      t.references :guest_session, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
