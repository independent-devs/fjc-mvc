# frozen_string_literal: true

class CreateVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :variants do |t|
      t.uuid :uuid, null: false, default: 'gen_random_uuid()'
      t.references :product, null: false, foreign_key: true
      t.string :sku
      t.integer :position
      t.decimal :cost, precision: 10, scale: 2
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :count_on_hand, default: 0
      t.boolean :is_master, null: false, default: false
      t.boolean :trackable, null: false, default: true
      t.boolean :backorderable, null: false, default: false
      t.string :thumbnail_url

      t.timestamps
    end

    add_index :variants, :uuid, unique: true
    add_index :variants, :position
    add_index :variants, :sku
  end
end
