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

ActiveRecord::Schema.define(version: 20140410214006) do

  create_table "alerts", force: true do |t|
    t.integer  "author_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["author_id"], name: "index_alerts_on_author_id"

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
    t.integer  "stype"
    t.string   "name"
    t.text     "default"
    t.text     "description"
    t.text     "type_opt"
    t.integer  "display_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_settings", ["game_id"], name: "index_game_settings_on_game_id"

  create_table "games", force: true do |t|
    t.text     "name"
    t.integer  "min_players_per_team"
    t.integer  "max_players_per_team"
    t.integer  "min_teams_per_match"
    t.integer  "max_teams_per_match"
    t.integer  "set_rounds"
    t.boolean  "randomized_teams"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hosts_tournaments", id: false, force: true do |t|
    t.integer "host_id",       null: false
    t.integer "tournament_id", null: false
  end

  create_table "matches", force: true do |t|
    t.integer  "status"
    t.integer  "tournament_id"
    t.string   "name"
    t.integer  "winner_id"
    t.string   "remote_id"
    t.integer  "submitted_peer_evaluations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["tournament_id"], name: "index_matches_on_tournament_id"
  add_index "matches", ["winner_id"], name: "index_matches_on_winner_id"

  create_table "matches_teams", id: false, force: true do |t|
    t.integer "match_id", null: false
    t.integer "team_id",  null: false
  end

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

  create_table "remote_usernames", force: true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.text     "json_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "remote_usernames", ["game_id"], name: "index_remote_usernames_on_game_id"
  add_index "remote_usernames", ["user_id"], name: "index_remote_usernames_on_user_id"

  create_table "scores", force: true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["match_id"], name: "index_scores_on_match_id"
  add_index "scores", ["user_id"], name: "index_scores_on_user_id"

  create_table "server_settings", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "teams", force: true do |t|
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["match_id"], name: "index_teams_on_match_id"

  create_table "teams_users", id: false, force: true do |t|
    t.integer "team_id", null: false
    t.integer "user_id", null: false
  end

  create_table "tournament_preferences", force: true do |t|
    t.integer  "tournament_id"
    t.integer  "vartype"
    t.string   "name"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournament_preferences", ["tournament_id"], name: "index_tournament_preferences_on_tournament_id"

  create_table "tournaments", force: true do |t|
    t.string   "name"
    t.integer  "game_id"
    t.integer  "status"
    t.integer  "min_players_per_team"
    t.integer  "max_players_per_team"
    t.integer  "min_teams_per_match"
    t.integer  "max_teams_per_match"
    t.integer  "set_rounds"
    t.boolean  "randomized_teams"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournaments", ["game_id"], name: "index_tournaments_on_game_id"

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
