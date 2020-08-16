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

ActiveRecord::Schema.define(version: 2020_08_16_170936) do

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.string "prompt"
    t.integer "length"
    t.text "generated_response"
    t.boolean "is_continuation", default: false
    t.boolean "start_at_beginning", default: true
    t.boolean "pause_at_end", default: false
    t.float "top_p", default: 0.9
    t.float "temperature", default: 1.0
    t.integer "user_id", null: false
    t.integer "generator_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["generator_id"], name: "index_documents_on_generator_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "generators", force: :cascade do |t|
    t.string "name"
    t.string "api_url"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.boolean "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "documents", "generators"
  add_foreign_key "documents", "users"
end
