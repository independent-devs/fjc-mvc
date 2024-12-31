# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts, id: :uuid do |t|
      t.integer :qty, null: false, default: 1
      t.references :variant, null: false, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
      t.references :guest_session, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :carts, %i[variant_id user_id guest_session_id], unique: true
    add_check_constraint :carts, '(user_id IS NOT NULL AND guest_session_id IS NULL) OR ' \
                                 '(user_id IS NULL AND guest_session_id IS NOT NULL)',
                         name: 'cart_ownership_cant_be_both'
  end
end
