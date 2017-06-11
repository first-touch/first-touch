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

ActiveRecord::Schema.define(version: 20170611094927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "club_id"
    t.string "title"
    t.datetime "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_awards_on_club_id"
    t.index ["user_id"], name: "index_awards_on_user_id"
  end

  create_table "career_entries", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "club_id"
    t.string "role"
    t.index ["club_id"], name: "index_career_entries_on_club_id"
    t.index ["user_id"], name: "index_career_entries_on_user_id"
  end

  create_table "club_users", id: :serial, force: :cascade do |t|
    t.integer "club_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_club_users_on_club_id"
    t.index ["user_id"], name: "index_club_users_on_user_id"
  end

  create_table "clubs", id: :serial, force: :cascade do |t|
    t.integer "account_owner_id"
    t.string "name"
    t.string "city"
    t.string "country_code"
    t.string "stadium_name"
    t.date "date_founded"
    t.string "twitter_handle"
    t.string "website"
    t.text "history"
    t.string "address"
    t.string "phone_number"
    t.string "email"
    t.string "facebook_link"
    t.string "home_kit_color"
    t.string "away_kit_color"
    t.string "third_kit_color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", id: :serial, force: :cascade do |t|
    t.string "imageable_type"
    t.integer "imageable_id"
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "interested_people", id: :serial, force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "request"
  end

  create_table "message_recipients", id: :serial, force: :cascade do |t|
    t.integer "recipient_id", null: false
    t.integer "message_id", null: false
    t.datetime "read_at"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.string "subject"
    t.text "message_body", null: false
    t.integer "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personal_profiles", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.date "birthday"
    t.string "nationality_country_code"
    t.string "residence_country_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "place_of_birth"
    t.float "weight"
    t.float "height"
    t.string "preferred_foot"
    t.string "languages", array: true
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.string "content", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", id: :serial, force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "session_plans", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "tags", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_session_plans_on_user_id"
  end

  create_table "team_users", id: :serial, force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_users_on_team_id"
    t.index ["user_id"], name: "index_team_users_on_user_id"
  end

  create_table "teams", id: :serial, force: :cascade do |t|
    t.string "team_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "club_id"
    t.index ["club_id"], name: "index_teams_on_club_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "search_string"
    t.string "password_digest"
    t.datetime "last_logout_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "awards", "clubs"
  add_foreign_key "awards", "users"
  add_foreign_key "career_entries", "clubs"
  add_foreign_key "career_entries", "users"
  add_foreign_key "club_users", "clubs"
  add_foreign_key "club_users", "users"
  add_foreign_key "session_plans", "users"
  add_foreign_key "team_users", "teams"
  add_foreign_key "team_users", "users"
end
