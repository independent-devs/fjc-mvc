# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :order_status, null: false, foreign_key: true, type: :uuid
      t.references :guest_session, foreign_key: true, type: :uuid
      t.string :tag

      t.timestamps
    end

    add_check_constraint :orders, '(user_id IS NOT NULL AND guest_session_id IS NULL) OR ' \
                                  '(user_id IS NULL AND guest_session_id IS NOT NULL)',
                         name: 'cart_ownership_cant_be_both'
  end
end
