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
  end
end
