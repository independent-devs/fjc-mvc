# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.datetime :available_on
      t.datetime :deleted_at
      t.string :slug, null: false
      t.text :meta_description
      t.string :meta_keywords
      t.boolean :promotionable, null: false, default: false
      t.string :meta_title

      t.timestamps
    end
  end
end
