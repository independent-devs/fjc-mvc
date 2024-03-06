# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_06_072255) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "position", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "available_on", precision: nil
    t.datetime "discontinue_on", precision: nil
    t.datetime "deleted_at", precision: nil
    t.string "slug", null: false
    t.text "meta_description"
    t.string "meta_keywords"
    t.boolean "promotionable", default: true, null: false
    t.boolean "require_login", default: false, null: false
    t.string "meta_title"
    t.decimal "lowest_price", precision: 10, scale: 2
    t.decimal "highest_price", precision: 10, scale: 2
    t.decimal "rating", precision: 1, scale: 1, default: "0.0"
    t.integer "raters", default: 0
    t.boolean "has_variant", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["available_on"], name: "index_products_on_available_on"
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
    t.index ["discontinue_on"], name: "index_products_on_discontinue_on"
    t.index ["highest_price"], name: "index_products_on_highest_price"
    t.index ["lowest_price"], name: "index_products_on_lowest_price"
    t.index ["name"], name: "index_products_on_name"
    t.index ["slug"], name: "index_products_on_slug"
    t.index ["uuid"], name: "index_products_on_uuid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "phone_no"
    t.string "name"
    t.boolean "admin", default: false, null: false
    t.string "provider", default: "phone_no"
    t.string "uid"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_no"], name: "index_users_on_phone_no", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "sku"
    t.integer "position", default: 1, null: false
    t.datetime "deleted_at"
    t.decimal "cost_price", precision: 10, scale: 2
    t.decimal "sell_price", precision: 10, scale: 2, null: false
    t.integer "count_on_hand", default: 0
    t.boolean "is_master", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_variants_on_position"
    t.index ["product_id"], name: "index_variants_on_product_id"
    t.index ["sku"], name: "index_variants_on_sku"
  end

  add_foreign_key "variants", "products"
end
