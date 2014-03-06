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

ActiveRecord::Schema.define(version: 20140306222447) do

  create_table "alerts", force: true do |t|
    t.integer  "author_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["author_id"], name: "index_alerts_on_author_id"

  create_table "game_options", force: true do |t|
    t.integer  "vartype"
    t.string   "name"
    t.text     "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "matches", force: true do |t|
    t.integer  "tournament_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["tournament_id"], name: "index_matches_on_tournament_id"

  create_table "pms", force: true do |t|
    t.integer  "author_id"
    t.integer  "recipient_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pms", ["author_id"], name: "index_pms_on_author_id"
  add_index "pms", ["recipient_id"], name: "index_pms_on_recipient_id"

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id"

  create_table "team_match_pairs", force: true do |t|
    t.integer  "team_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_match_pairs", ["match_id"], name: "index_team_match_pairs_on_match_id"
  add_index "team_match_pairs", ["team_id"], name: "index_team_match_pairs_on_team_id"

  create_table "teams", force: true do |t|
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["match_id"], name: "index_teams_on_match_id"

  create_table "tournament_options", force: true do |t|
    t.integer  "tournament_id"
    t.integer  "vartype"
    t.string   "name"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournament_options", ["tournament_id"], name: "index_tournament_options_on_tournament_id"

  create_table "tournament_user_pairs", force: true do |t|
    t.integer  "tournament_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournament_user_pairs", ["tournament_id"], name: "index_tournament_user_pairs_on_tournament_id"
  add_index "tournament_user_pairs", ["user_id"], name: "index_tournament_user_pairs_on_user_id"

  create_table "tournaments", force: true do |t|
    t.integer  "game_id"
    t.integer  "min_players_per_team"
    t.integer  "max_players_per_team"
    t.integer  "min_teams_per_match"
    t.integer  "max_teams_per_match"
    t.integer  "set_rounds"
    t.boolean  "randomized_teams"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournaments", ["game_id"], name: "index_tournaments_on_game_id"

  create_table "user_team_pairs", force: true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_team_pairs", ["team_id"], name: "index_user_team_pairs_on_team_id"
  add_index "user_team_pairs", ["user_id"], name: "index_user_team_pairs_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "groups"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", unique: true
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true

end
