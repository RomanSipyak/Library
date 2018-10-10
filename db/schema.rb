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

ActiveRecord::Schema.define(version: 2018_10_10_042312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
    t.text "biography"
    t.integer "books_count", default: 0
    t.index ["name"], name: "index_authors_on_name", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "start_booking", null: false
    t.datetime "end_booking", null: false
    t.string "code"
    t.bigint "unit_id"
    t.bigint "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_bookings_on_code", unique: true
    t.index ["unit_id"], name: "index_bookings_on_unit_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.integer "year", null: false
    t.text "description", null: false
    t.integer "units_count", default: 0
    t.float "rating", default: 0.0
    t.bigint "author_id"
    t.bigint "category_id"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["language_id"], name: "index_books_on_language_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title", null: false
    t.integer "books_count", default: 0
  end

  create_table "estimates", force: :cascade do |t|
    t.float "rating", default: 0.0
    t.bigint "user_id"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_estimates_on_book_id"
    t.index ["user_id"], name: "index_estimates_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "language", null: false
    t.integer "books_count", default: 0
  end

  create_table "units", force: :cascade do |t|
    t.boolean "available", default: true
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_units_on_book_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.boolean "admin", default: false
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
    t.boolean "debtor", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
