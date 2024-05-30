# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.uuid :uuid, null: false, default: 'gen_random_uuid()'
      t.references :user, foreign_key: true
      t.references :order_status, null: false, foreign_key: true
      t.references :guest_session, foreign_key: true

      t.timestamps
    end

    add_index :orders, :uuid, unique: true
  end
end
