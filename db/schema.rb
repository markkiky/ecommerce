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

ActiveRecord::Schema.define(version: 2020_08_13_184229) do

  create_table "customers", force: :cascade do |t|
    t.string "customer_id"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "homes", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
