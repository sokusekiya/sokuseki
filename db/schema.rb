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

ActiveRecord::Schema[7.1].define(version: 2020_01_07_134431) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "authentication_id"
    t.string "activity_id", null: false
    t.string "activity_type", null: false
    t.datetime "acted_at", precision: nil, null: false
    t.jsonb "original_data"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["acted_at"], name: "index_activities_on_acted_at"
    t.index ["activity_id", "activity_type"], name: "index_activities_on_activity_id_and_activity_type", unique: true
    t.index ["authentication_id"], name: "index_activities_on_authentication_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "name", null: false
    t.string "access_token", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "shared_links", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "expired_at", precision: nil, null: false
    t.string "on", null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_shared_links_on_token", unique: true
    t.index ["user_id"], name: "index_shared_links_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "avatar_url", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "activities", "authentications"
  add_foreign_key "activities", "users"
  add_foreign_key "authentications", "users"
  add_foreign_key "shared_links", "users"
end
