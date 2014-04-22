# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140422212727) do

  create_table "alerts", force: true do |t|
    t.integer  "author_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["author_id"], name: "index_alerts_on_author_id"

  create_table "api_requests", force: true do |t|
    t.string   "api_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bracket_matches", force: true do |t|
    t.integer  "bracket_id"
    t.integer  "match_id"
    t.integer  "predicted_winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bracket_matches", ["bracket_id"], name: "index_bracket_matches_on_bracket_id"
  add_index "bracket_matches", ["match_id"], name: "index_bracket_matches_on_match_id"
  add_index "bracket_matches", ["predicted_winner_id"], name: "index_bracket_matches_on_predicted_winner_id"

  create_table "brackets", force: true do |t|
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brackets", ["tournament_id"], name: "index_brackets_on_tournament_id"
  add_index "brackets", ["user_id"], name: "index_brackets_on_user_id"

  create_table "conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "game_settings", force: true do |t|
    t.integer  "game_id"
    t.string   "name"
    t.integer  "vartype"
    t.text     "type_opt"
    t.text     "description"
    t.integer  "display_order"
    t.text     "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_settings", ["game_id"], name: "index_game_settings_on_game_id"

  create_table "games", force: true do |t|
    t.string   "name"
    t.integer  "min_players_per_team"
    t.integer  "max_players_per_team"
    t.integer  "min_teams_per_match"
    t.integer  "max_teams_per_match"
    t.integer  "set_rounds"
    t.boolean  "randomized_teams"
    t.string   "sampling_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["name"], name: "index_games_on_name", unique: true

  create_table "hosts_tournaments", id: false, force: true do |t|
    t.integer "host_id",       null: false
    t.integer "tournament_id", null: false
  end

  create_table "matches", force: true do |t|
    t.integer  "status"
    t.integer  "tournament_stage_id"
    t.integer  "winner_id"
    t.text     "remote_id"
    t.integer  "submitted_peer_evaluations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["tournament_stage_id"], name: "index_matches_on_tournament_stage_id"
  add_index "matches", ["winner_id"], name: "index_matches_on_winner_id"

  create_table "matches_teams", id: false, force: true do |t|
    t.integer "match_id", null: false
    t.integer "team_id",  null: false
  end

  create_table "notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], name: "index_notifications_on_conversation_id"

  create_table "players_tournaments", id: false, force: true do |t|
    t.integer "player_id",     null: false
    t.integer "tournament_id", null: false
  end

  create_table "pms", force: true do |t|
    t.integer  "author_id"
    t.integer  "recipient_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pms", ["author_id"], name: "index_pms_on_author_id"
  add_index "pms", ["recipient_id"], name: "index_pms_on_recipient_id"

  create_table "receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "receipts", ["notification_id"], name: "index_receipts_on_notification_id"

  create_table "remote_usernames", force: true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.text     "json_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "remote_usernames", ["game_id"], name: "index_remote_usernames_on_game_id"
  add_index "remote_usernames", ["user_id"], name: "index_remote_usernames_on_user_id"

  create_table "servers", force: true do |t|
    t.integer  "default_user_permissions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["token"], name: "index_sessions_on_token", unique: true
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id"

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key"

  create_table "statistics", force: true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statistics", ["match_id"], name: "index_statistics_on_match_id"
  add_index "statistics", ["user_id"], name: "index_statistics_on_user_id"

  create_table "teams", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams_users", id: false, force: true do |t|
    t.integer "team_id", null: false
    t.integer "user_id", null: false
  end

  create_table "tournament_settings", force: true do |t|
    t.integer  "tournament_id"
    t.string   "name"
    t.integer  "vartype"
    t.text     "type_opt"
    t.text     "description"
    t.integer  "display_order"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournament_settings", ["tournament_id"], name: "index_tournament_settings_on_tournament_id"

  create_table "tournament_stages", force: true do |t|
    t.integer  "tournament_id"
    t.string   "scheduling"
    t.text     "structure"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournament_stages", ["tournament_id"], name: "index_tournament_stages_on_tournament_id"

  create_table "tournaments", force: true do |t|
    t.integer  "game_id"
    t.integer  "status"
    t.string   "name"
    t.integer  "min_players_per_team"
    t.integer  "max_players_per_team"
    t.integer  "min_teams_per_match"
    t.integer  "max_teams_per_match"
    t.integer  "set_rounds"
    t.boolean  "randomized_teams"
    t.string   "sampling_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournaments", ["game_id"], name: "index_tournaments_on_game_id"
  add_index "tournaments", ["name"], name: "index_tournaments_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.integer  "permissions"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true

end
