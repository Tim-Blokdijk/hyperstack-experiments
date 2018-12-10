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

ActiveRecord::Schema.define(version: 2018_12_10_231656) do

  create_table "aspects", force: :cascade do |t|
    t.string "name"
  end

  create_table "clients", force: :cascade do |t|
    t.string "login"
    t.string "password_hash"
    t.string "password_salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "criteria", force: :cascade do |t|
    t.string "select"
    t.integer "score"
    t.string "rationale"
    t.boolean "active", default: false, null: false
    t.integer "search_profile_id"
    t.integer "aspect_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aspect_id"], name: "index_criteria_on_aspect_id"
    t.index ["search_profile_id"], name: "index_criteria_on_search_profile_id"
  end

  create_table "hyperstack_connections", force: :cascade do |t|
    t.string "channel"
    t.string "session"
    t.datetime "created_at"
    t.datetime "expires_at"
    t.datetime "refresh_at"
  end

  create_table "hyperstack_queued_messages", force: :cascade do |t|
    t.text "data"
    t.integer "connection_id"
  end

  create_table "search_profiles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_search_profiles_on_client_id"
  end

  create_table "search_profiles_aspects", force: :cascade do |t|
    t.string "data"
    t.integer "search_profile_id"
    t.integer "aspect_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aspect_id"], name: "index_search_profiles_aspects_on_aspect_id"
    t.index ["search_profile_id"], name: "index_search_profiles_aspects_on_search_profile_id"
  end

end
