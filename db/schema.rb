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

ActiveRecord::Schema.define(version: 20140304015357) do

  create_table "alerts", force: true do |t|
    t.integer  "author_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["author_id"], name: "index_alerts_on_author_id"

  create_table "game_attributes", force: true do |t|
    t.integer  "game_id"
    t.text     "key"
    t.integer  "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_attributes", ["game_id"], name: "index_game_attributes_on_game_id"

  create_table "games", force: true do |t|
    t.text     "name"
    t.integer  "players_per_team"
    t.integer  "teams_per_match"
    t.integer  "set_rounds"
    t.integer  "randomized_teams"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.integer  "tournament_id"
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

  create_table "server_settings", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_match_pairs", force: true do |t|
    t.integer  "team_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_match_pairs", ["match_id"], name: "index_team_match_pairs_on_match_id"
  add_index "team_match_pairs", ["team_id"], name: "index_team_match_pairs_on_team_id"

  create_table "teams", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournament_options", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournaments", force: true do |t|
    t.integer  "game_id"
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
    t.text     "name"
    t.text     "pw_hash"
    t.integer  "groups"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
