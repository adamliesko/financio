# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150228222408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_transactions", force: :cascade do |t|
    t.integer "category_id"
    t.integer "account_id"
    t.float "value"
    t.string "purpose"
    t.date "transaction_date"
    t.string "subject"
  end

  add_index "account_transactions", ["account_id"], name: "index_account_transactions_on_account_id", using: :btree
  add_index "account_transactions", ["category_id"], name: "index_account_transactions_on_category_id", using: :btree

  create_table "accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.boolean "send_notifications"
    t.float "critical_value"
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "user_logins", force: :cascade do |t|
    t.integer "user_id"
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "signed_in_at"
    t.datetime "last_seen_at"
    t.datetime "signed_out_at"
  end

  add_index "user_logins", ["user_id"], name: "index_user_logins_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "unique_session_id", limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "role"
    t.string "current_sign_in_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
