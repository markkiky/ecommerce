# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_09_080024) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "admin_id"
    t.bigint "role_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.boolean "owner"
    t.boolean "vendor"
    t.boolean "shipper"
    t.boolean "supplier"
    t.boolean "otp_confirmed", default: false
    t.string "otp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "api_urls", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key"
    t.string "value"
  end

  create_table "cars", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "car_make"
    t.string "car_model"
    t.string "car_year"
    t.string "chassis_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "category_id"
    t.string "category_name"
    t.text "description"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_id"
  end

  create_table "category_variants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "variant_name"
    t.string "variant_value"
    t.string "variant_code"
    t.string "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "colors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "color_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_id"
    t.string "category_id"
    t.string "color_code"
  end

  create_table "complete_orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "order_id"
    t.string "customer_id"
    t.string "order_number"
    t.string "payment_id"
    t.datetime "order_date"
    t.string "required_date"
    t.string "shipper_id"
    t.string "freight"
    t.decimal "sales_tax", precision: 10
    t.string "transaction_status"
    t.boolean "paid"
    t.datetime "payment_date"
    t.boolean "deleted"
    t.boolean "fulfilled"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "customer_id"
    t.string "customer_no"
    t.string "first_name"
    t.string "last_name"
    t.string "customer_class"
    t.string "room"
    t.string "building"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "county"
    t.string "phone"
    t.string "email"
    t.string "password"
    t.string "credit_card"
    t.integer "credit_card_type_id"
    t.integer "card_exp_mo"
    t.integer "card_exp_yr"
    t.string "billing_address"
    t.string "billing_city"
    t.string "billing_region"
    t.string "billing_postal_code"
    t.string "billing_country"
    t.string "shipping_address"
    t.string "shipping_city"
    t.string "shipping_region"
    t.string "shipping_postal_code"
    t.string "shipping_country"
    t.boolean "otp_confirmed", default: false
    t.string "otp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.string "location"
    t.string "image_url"
    t.string "url"
    t.string "shipping_option"
    t.string "pick_up_option"
    t.string "delivery_option"
    t.string "car_name"
    t.string "car_make"
    t.string "car_year"
    t.string "chassis_number"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["provider", "uid"], name: "index_customers_on_provider_and_uid", unique: true
    t.index ["provider"], name: "index_customers_on_provider"
    t.index ["uid"], name: "index_customers_on_uid"
  end

  create_table "homes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "notification_first_name"
    t.string "notification_last_name"
    t.string "notification_phone_number"
    t.string "notification_subject"
    t.string "notification_email"
    t.text "notification_message"
    t.boolean "notification_read", default: false
  end

  create_table "order_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "price", precision: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id", null: false
    t.bigint "order_id", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "order_id"
    t.string "customer_id"
    t.bigint "status_id", default: 5
    t.decimal "order_total", precision: 10
    t.string "order_number"
    t.string "transaction_id"
    t.datetime "order_date"
    t.datetime "ship_date"
    t.datetime "required_date"
    t.datetime "shipper_date"
    t.string "freight"
    t.string "sales_tax"
    t.datetime "timestamp"
    t.string "transact_status"
    t.string "err_loc"
    t.string "err_msg"
    t.boolean "fulfilled"
    t.boolean "deleted"
    t.boolean "paid", default: false
    t.datetime "payment_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token"
    t.string "order_status", default: "cart"
    t.decimal "order_subtotal", precision: 10
    t.string "payment_method"
    t.string "payment_status", default: "Unpaid"
    t.decimal "reducing_balance", precision: 10
    t.integer "admin_id"
  end

  create_table "product_colors", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "color_id", null: false
    t.index ["color_id"], name: "index_product_colors_on_color_id"
    t.index ["product_id"], name: "index_product_colors_on_product_id"
  end

  create_table "product_sizes", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "size_id", null: false
    t.index ["product_id"], name: "index_product_sizes_on_product_id"
    t.index ["size_id"], name: "index_product_sizes_on_size_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "product_id"
    t.string "category_id"
    t.string "sub_category_id"
    t.string "sku"
    t.string "id_sku"
    t.string "vendor_product_id"
    t.string "product_name"
    t.text "product_description"
    t.string "supplier_id"
    t.string "quantity_per_unit"
    t.decimal "price", precision: 10
    t.decimal "unit_price", precision: 10
    t.string "msrp"
    t.string "available_size"
    t.string "available_colors"
    t.string "size"
    t.string "color"
    t.string "discount"
    t.string "unit_weight"
    t.string "units_in_stock"
    t.string "units_on_order"
    t.string "reorder_level"
    t.string "product_available"
    t.string "discount_available"
    t.string "current_order"
    t.string "note"
    t.string "ranking"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_id"
    t.string "product_code"
    t.integer "product_quantity"
    t.integer "size_id"
    t.integer "color_id"
    t.string "year"
  end

  create_table "reviews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "customer_id"
    t.integer "product_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
  end

  create_table "sessions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "shopping_carts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sizes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "size_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_id"
    t.string "category_id"
  end

  create_table "statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sub_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "transaction_id"
    t.string "order_id"
    t.bigint "status_id", default: 1
    t.string "full_names"
    t.decimal "amount", precision: 10
    t.string "phone_number"
    t.string "transaction_code"
    t.string "message"
    t.datetime "date"
    t.string "payment_mode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "paybill_number"
    t.string "account_reference"
    t.string "transaction_description"
    t.string "status"
    t.string "reconciliation_id"
    t.string "currency"
  end

  create_table "wishlists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_wishlists_on_customer_id"
    t.index ["product_id"], name: "index_wishlists_on_product_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "product_colors", "colors"
  add_foreign_key "product_colors", "products"
  add_foreign_key "product_sizes", "products"
  add_foreign_key "product_sizes", "sizes"
  add_foreign_key "wishlists", "customers"
  add_foreign_key "wishlists", "products"
end
