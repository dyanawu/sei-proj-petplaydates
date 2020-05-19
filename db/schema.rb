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

ActiveRecord::Schema.define(version: 2020_05_19_105625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "capacity"
    t.string "location"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "min_pets"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "events_pets", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "pet_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_events_pets_on_event_id"
    t.index ["pet_id"], name: "index_events_pets_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "dp_url"
    t.date "birthday"
    t.text "bio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "species_id", null: false
    t.bigint "user_id", null: false
    t.index ["species_id"], name: "index_pets_on_species_id"
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "dp_url"
    t.text "bio"
    t.string "location"
    t.string "gender"
    t.date "birthday"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "species", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "events", "users"
  add_foreign_key "pets", "species"
  add_foreign_key "pets", "users"
end
