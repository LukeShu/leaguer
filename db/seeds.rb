# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Game.create(name: "League of Legends",min_players_per_team: 5,  max_players_per_team: 5, min_teams_per_match: 2, max_teams_per_match: 2, set_rounds: nil, randomized_teams: true)
Game.create(name: "Chess", min_players_per_team: 1,  max_players_per_team: 1, min_teams_per_match: 2, max_teams_per_match: 2, set_rounds: nil, randomized_teams: true)
Game.create(name: "Hearthstone", min_players_per_team: 1, max_players_per_team: 1, min_teams_per_match: 2, max_teams_per_match: 2, set_rounds: 1, randomized_teams: false)

Game.find_by_name("League of Legends").settings.create(name: "Map", default: "Summoners Rift", type_opt: "Summoners Rift,Twisted Treeline,Crystal Scar,Haunted Abyss", description: "Select a map to play on.", stype: 5, display_order: 1)
Game.find_by_name("League of Legends").settings.create(name: "Pick Type", type_opt: "Blind Pick,Draft", description: "Select a pick type.", stype: 5, display_order: 2)

#Game_setting.create(game_id: , type: , name: , default: , description: , type_opt: , display_order: , created_at: , updated_at: )

#User.create(id: 1, name: "Andrew", email: "amurrel@example.com", user_name: "ImFromNASA", created_at: "2014-03-07 22:48:53", updated_at: "2014-03-07 22:48:53", password_digest: "$2a$10$W0FwPRDzdQp8arolCHGt5ezXqkOiTLNsXI5GKGtu9qr3...", remember_token: "1583722b02663e024533296171cad79f29037ebc", groups: 0)
