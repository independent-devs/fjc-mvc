# frozen_string_literal: true

class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_methods, id: :uuid do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.boolean :enable, null: false, default: false
      t.json :credentials

      t.timestamps
    end

    add_index :payment_methods, :name
    add_index :payment_methods, :code, unique: true

    reversible do |dir|
      dir.up do
        PaymentMethod.create(name: 'Cash on delivery (COD)', code: 'COD', enable: true)
        PaymentMethod.create(name: 'GCash E-wallet', code: 'GCASH')
        PaymentMethod.create(name: 'Credit / Debit Card', code: 'CARD')
      end
    end
  end
end
