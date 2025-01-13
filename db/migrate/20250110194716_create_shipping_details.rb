# frozen_string_literal: true

class CreateShippingDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_details, id: :uuid do |t|
      t.references :shippable, polymorphic: true, null: false, type: :uuid
      t.string :fullname, null: false
      t.string :phone_no, null: false
      t.string :email
      t.string :street, null: false
      t.string :barangay, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.string :postal_code

      t.timestamps
    end
  end
end
