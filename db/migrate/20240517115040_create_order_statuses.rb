# frozen_string_literal: true

class CreateOrderStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :order_statuses, id: :uuid do |t|
      t.string :name, null: false
      t.integer :step, null: false

      t.timestamps
    end

    add_index :order_statuses, :name, unique: true
    add_index :order_statuses, :step, unique: true

    reversible do |dir|
      dir.up do
        OrderStatus::STATUSES.each_with_index do |status, index|
          OrderStatus.create(name: status, step: index + 1)
        end
      end
    end
  end
end
