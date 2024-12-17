# frozen_string_literal: true

class CreateOrderStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :order_statuses, id: :uuid do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :order_statuses, :name, unique: true

    reversible do |dir|
      dir.up do
        %w[pending to_ship to_recieve completed cancelled returned refunded].each do |status|
          OrderStatus.create(name: status)
        end
      end
    end
  end
end
