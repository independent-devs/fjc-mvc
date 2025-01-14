# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :order_status, null: false, foreign_key: true, type: :uuid
      t.references :guest_session, foreign_key: true, type: :uuid
      t.references :payment_method, foreign_key: true, type: :uuid
      t.decimal :shipping_fee, precision: 10, scale: 2, null: false, default: 0
      t.datetime :placed_at
      t.string :logistic_url
      t.string :logistic_ref
      t.text :refund_reason
      t.text :return_reason
      t.text :internal_note

      t.timestamps
    end
  end
end
