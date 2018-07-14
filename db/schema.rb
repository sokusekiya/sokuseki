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

ActiveRecord::Schema.define(version: 2018_07_14_072854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "authentication_id"
    t.string "activity_id", null: false
    t.string "activity_type", null: false
    t.datetime "act_at", null: false
    t.jsonb "original_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["act_at"], name: "index_activities_on_act_at"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "avatar_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "activities", "authentications"
  add_foreign_key "activities", "users"
  add_foreign_key "authentications", "users"
end
