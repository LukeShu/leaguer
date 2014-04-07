# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
p = User.permission_bits
Server.create(default_user_permissions: p[:join_tournament] | p[:create_pm])

Game.create(name: "League of Legends",min_players_per_team: 5,  max_players_per_team: 5, min_teams_per_match: 2, max_teams_per_match: 2, set_rounds: nil, randomized_teams: true)
Game.create(name: "Chess", min_players_per_team: 1,  max_players_per_team: 1, min_teams_per_match: 2, max_teams_per_match: 2, set_rounds: nil, randomized_teams: true)
Game.create(name: "Hearthstone", min_players_per_team: 1, max_players_per_team: 1, min_teams_per_match: 2, max_teams_per_match: 2, set_rounds: 1, randomized_teams: false)

Game.find_by_name("League of Legends").settings.create(name: "Map", default: "Summoners Rift", type_opt: "Summoners Rift,Twisted Treeline,Crystal Scar,Haunted Abyss", description: "Select a map to play on.", stype: 5, display_order: 1)
Game.find_by_name("League of Legends").settings.create(name: "Pick Type", type_opt: "Blind Pick,Draft", description: "Select a pick type.", stype: 5, display_order: 2)

Game.find_by_name("Chess").settings.create(name: "Time Control", description: "Enter a value for Time Control (ie. 5-5, 30, 6hr, or None)", stype: 1, display_order: 1)

Game.find_by_name("Hearthstone").settings.create(name: "Deck Name", description: "Enter a name for your deck, be descriptive.", stype: 2, display_order: 1)

