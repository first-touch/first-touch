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

ActiveRecord::Schema.define(version: 20180411094531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_notification_templates", force: :cascade do |t|
    t.string "ref"
    t.string "available_fields"
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "app_notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.text "content"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_app_notifications_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.text "url"
    t.text "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "report_id"
    t.index ["report_id"], name: "index_attachments_on_report_id"
  end

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

  create_table "competition_seasons", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.bigint "competition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id"], name: "index_competition_seasons_on_competition_id"
  end

  create_table "competitions", force: :cascade do |t|
    t.string "name"
    t.integer "competition_type"
    t.string "sponsor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nation"
  end

  create_table "connections", force: :cascade do |t|
    t.integer "user_id"
    t.integer "connected_to_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connected_to_id"], name: "index_connections_on_connected_to_id"
    t.index ["user_id", "connected_to_id"], name: "index_connections_on_user_id_and_connected_to_id", unique: true
    t.index ["user_id"], name: "index_connections_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "evt_type"
    t.integer "organizer_id"
    t.integer "opponent_id"
    t.string "name"
    t.string "venue"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["opponent_id"], name: "index_events_on_opponent_id"
    t.index ["organizer_id"], name: "index_events_on_organizer_id"
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

  create_table "notes", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "labels", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "customer_id"
    t.integer "price"
    t.bigint "report_id"
    t.text "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["report_id"], name: "index_orders_on_report_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
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
    t.string "playing_position"
    t.string "pro_status"
    t.integer "total_caps"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "author_id"
    t.string "author_type"
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

  create_table "reports", force: :cascade do |t|
    t.text "headline"
    t.string "status"
    t.string "type_report"
    t.bigint "user_id"
    t.integer "price"
    t.bigint "club_id"
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "meta_data"
    t.index ["club_id"], name: "index_reports_on_club_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.text "type_request"
    t.integer "min_price"
    t.integer "max_price"
    t.bigint "user_id"
    t.date "deadline"
    t.text "status"
    t.json "meta_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "statistics", force: :cascade do |t|
    t.integer "stat_type"
    t.jsonb "metadata", default: "{}", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "teams_competitions", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "competition_season_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_season_id"], name: "index_teams_competitions_on_competition_season_id"
    t.index ["team_id"], name: "index_teams_competitions_on_team_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "search_string"
    t.string "password_digest"
    t.datetime "last_logout_at"
    t.boolean "unclaimed"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "app_notifications", "users"
  add_foreign_key "attachments", "reports"
  add_foreign_key "awards", "clubs"
  add_foreign_key "awards", "users"
  add_foreign_key "career_entries", "clubs"
  add_foreign_key "career_entries", "users"
  add_foreign_key "club_users", "clubs"
  add_foreign_key "club_users", "users"
  add_foreign_key "competition_seasons", "competitions"
  add_foreign_key "notes", "users"
  add_foreign_key "orders", "reports"
  add_foreign_key "orders", "users"
  add_foreign_key "reports", "clubs"
  add_foreign_key "reports", "users"
  add_foreign_key "requests", "users"
  add_foreign_key "team_users", "teams"
  add_foreign_key "team_users", "users"
  add_foreign_key "teams_competitions", "competition_seasons"
  add_foreign_key "teams_competitions", "teams"
end
