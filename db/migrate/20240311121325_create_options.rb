# frozen_string_literal: true

class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.string :name
      t.references :option_type, null: false, foreign_key: true
      # for product specific options
      t.references :product, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :options, :deleted_at
  end
end
