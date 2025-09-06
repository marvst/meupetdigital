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

ActiveRecord::Schema[8.0].define(version: 2025_07_20_063257) do
  create_table "auth_tokens", force: :cascade do |t|
    t.string "token"
    t.integer "user_id", null: false
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_auth_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_auth_tokens_on_user_id"
  end

  create_table "pet_users", force: :cascade do |t|
    t.integer "pet_id", null: false
    t.integer "user_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_pet_users_on_pet_id"
    t.index ["user_id"], name: "index_pet_users_on_user_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "species"
    t.string "breed"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["user_id"], name: "index_pets_on_user_id"
    t.index ["uuid"], name: "index_pets_on_uuid", unique: true
  end

  create_table "pets_infos", force: :cascade do |t|
    t.integer "pet_id", null: false
    t.integer "created_by_id", null: false
    t.string "name"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "channels"
    t.index ["created_by_id"], name: "index_pets_infos_on_created_by_id"
    t.index ["pet_id"], name: "index_pets_infos_on_pet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "auth_tokens", "users"
  add_foreign_key "pet_users", "pets"
  add_foreign_key "pet_users", "users"
  add_foreign_key "pets", "users"
  add_foreign_key "pets_infos", "pets"
  add_foreign_key "pets_infos", "users", column: "created_by_id"
end
