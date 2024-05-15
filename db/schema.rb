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

ActiveRecord::Schema[7.1].define(version: 2024_05_15_205633) do
  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.integer "number"
    t.string "district"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buffets", force: :cascade do |t|
    t.string "trade_name"
    t.string "company_name"
    t.string "registration_number"
    t.string "telephone"
    t.string "email"
    t.integer "address_id", null: false
    t.string "description"
    t.string "payment_types"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id", null: false
    t.index ["address_id"], name: "index_buffets_on_address_id"
    t.index ["owner_id"], name: "index_buffets_on_owner_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "event_description"
    t.integer "minimum_of_people"
    t.integer "maximum_of_people"
    t.integer "duration"
    t.string "menu"
    t.integer "alcoholic_drink", default: 0
    t.integer "ornamentation", default: 0
    t.integer "valet", default: 0
    t.integer "locality", default: 0
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_events_on_buffet_id"
  end

  create_table "order_budgets", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "standard_value"
    t.date "deadline"
    t.integer "rate", default: 0
    t.integer "rate_value"
    t.string "rate_description"
    t.string "payment_options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_budgets_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "buffet_id", null: false
    t.integer "event_id", null: false
    t.date "date"
    t.integer "number_of_guests"
    t.string "other_details"
    t.string "code"
    t.integer "status", default: 0
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_orders_on_buffet_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["event_id"], name: "index_orders_on_event_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "prices", force: :cascade do |t|
    t.integer "minimum_cost"
    t.integer "add_cost_by_person"
    t.integer "add_cost_by_hour"
    t.string "weekday"
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_prices_on_event_id"
  end

  add_foreign_key "buffets", "addresses"
  add_foreign_key "buffets", "owners"
  add_foreign_key "events", "buffets"
  add_foreign_key "order_budgets", "orders"
  add_foreign_key "orders", "buffets"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "events"
  add_foreign_key "prices", "events"
end
