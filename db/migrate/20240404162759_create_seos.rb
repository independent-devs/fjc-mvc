# frozen_string_literal: true

class CreateSeos < ActiveRecord::Migration[7.0]
  def change
    create_table :seos do |t|
      t.references :product, null: false, foreign_key: true
      t.string :meta_title
      t.string :meta_description
      t.string :meta_keywords

      t.timestamps
    end
  end
end
