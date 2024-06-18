# frozen_string_literal: true

class CreateOrderStatusTags < ActiveRecord::Migration[7.0]
  def change
    create_table :order_status_tags do |t|
      t.references :order, null: false, foreign_key: true
      t.references :order_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
