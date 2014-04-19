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

if ENV["RAILS_ENV"] and ENV["RAILS_ENV"] != "development"
	User.create(name: "Administrator", user_name: "admin", email: "root@localhost", password: "password", password_confirmation: "password", permissions: 0xFFFFFFFF)

	User.create(name: "John 0", password: "password", email: "john0@gmail.com", user_name: "johndoe0", password_confirmation: "password")
	User.create(name: "John 1", password: "password", email: "john1@gmail.com", user_name: "johndoe1", password_confirmation: "password")
	User.create(name: "John 2", password: "password", email: "john2@gmail.com", user_name: "johndoe2", password_confirmation: "password")
	User.create(name: "John 3", password: "password", email: "john3@gmail.com", user_name: "johndoe3", password_confirmation: "password")
	User.create(name: "John 4", password: "password", email: "john4@gmail.com", user_name: "johndoe4", password_confirmation: "password")
	User.create(name: "John 5", password: "password", email: "john5@gmail.com", user_name: "johndoe5", password_confirmation: "password")
	User.create(name: "John 6", password: "password", email: "john6@gmail.com", user_name: "johndoe6", password_confirmation: "password")
	User.create(name: "John 7", password: "password", email: "john7@gmail.com", user_name: "johndoe7", password_confirmation: "password")
	User.create(name: "John 8", password: "password", email: "john8@gmail.com", user_name: "johndoe8", password_confirmation: "password")
	User.create(name: "John 9", password: "password", email: "john9@gmail.com", user_name: "johndoe9", password_confirmation: "password")

	User.create(name: "Sytrie", password: "password", email: "Sytrie@gmail.com", user_name: "Sytrie", password_confirmation: "password")
	User.create(name: "Derpanator115", password: "password", email: "Derpanator115@gmail.com", user_name: "Derpanator115", password_confirmation: "password")
	User.create(name: "Wlknexe56", password: "password", email: "Wlknexe56@gmail.com", user_name: "Wlknexe56", password_confirmation: "password")
	User.create(name: "DVisionzz", password: "password", email: "DVisionzz@gmail.com", user_name: "DVisionzz", password_confirmation: "password")
	User.create(name: "HYP3RTONIC", password: "password", email: "HYP3RTONIC@gmail.com", user_name: "HYP3RTONIC", password_confirmation: "password")
	User.create(name: "M9Fumjaa", password: "password", email: "M9Fumjaa@gmail.com", user_name: "M9Fumjaa", password_confirmation: "password")
	User.create(name: "spikevsnaruto", password: "password", email: "spikevsnaruto@gmail.com", user_name: "spikevsnaruto", password_confirmation: "password")
	User.create(name: "GoogleMaSkills", password: "password", email: "GoogleMaSkills@gmail.com", user_name: "GoogleMaSkills", password_confirmation: "password")
	User.create(name: "james chamberlan", password: "password", email: "james chamberlan@gmail.com", user_name: "james chamberlan", password_confirmation: "password")
	User.create(name: "Kaceytron", password: "password", email: "Kaceytron@gmail.com", user_name: "Kaceytron", password_confirmation: "password")
end
