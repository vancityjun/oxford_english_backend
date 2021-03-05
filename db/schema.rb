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

ActiveRecord::Schema.define(version: 2021_03_04_032913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "definitions", force: :cascade do |t|
    t.text "content"
    t.string "form"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "notes_id"
    t.index ["notes_id"], name: "index_definitions_on_notes_id"
  end

  create_table "examples", force: :cascade do |t|
    t.bigint "definitions_id"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["definitions_id"], name: "index_examples_on_definitions_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "users_id"
    t.bigint "vocabularies_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["users_id"], name: "index_notes_on_users_id"
    t.index ["vocabularies_id"], name: "index_notes_on_vocabularies_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password"
    t.string "encrypted_password_iv"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vocabularies", force: :cascade do |t|
    t.string "word"
    t.string "level"
    t.string "pos"
    t.boolean "ox5000"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "definitions", "notes", column: "notes_id"
  add_foreign_key "notes", "users", column: "users_id"
  add_foreign_key "notes", "vocabularies", column: "vocabularies_id"
end
