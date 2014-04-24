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

Game.create(name: "League of Legends",min_players_per_team: 5,  max_players_per_team: 5, min_teams_per_match: 2, max_teams_per_match: 2, set_rounds: nil, randomized_teams: true, sampling_method: "Manual,Double Blind,RiotAPI")
Game.create(name: "Chess", min_players_per_team: 1,  max_players_per_team: 1, min_teams_per_match: 2, max_teams_per_match: 2, set_rounds: nil, randomized_teams: true, sampling_method: "Manual,Double Blind")
Game.create(name: "Hearthstone", min_players_per_team: 1, max_players_per_team: 1, min_teams_per_match: 2, max_teams_per_match: 2, set_rounds: 1, randomized_teams: false, sampling_method: "Manual,Double Blind")
Game.create(name: "Rock, Paper, Scissors", min_players_per_team: 1, max_players_per_team: 3, min_teams_per_match: 2, max_teams_per_match: 2, set_rounds: nil, randomized_teams: false, sampling_method: "Manual,Double Blind")

Game.find_by_name("League of Legends").settings.create(name: "Map", default: "Summoners Rift", type_opt: "Summoners Rift,Twisted Treeline,Crystal Scar,Haunted Abyss", description: "Select a map to play on.", vartype: 5, display_order: 1)
Game.find_by_name("League of Legends").settings.create(name: "Pick Type", type_opt: "Blind Pick,Draft", description: "Select a pick type.", vartype: 5, display_order: 2)
Game.find_by_name("League of Legends").settings.create(name: "Scoring Method", type_opt: "FibonacciPeerWithBlowout,MarginalPeer,WinnerTakesAll", description: "Select Scoring Method", vartype: 5, display_order: 3)
Game.find_by_name("League of Legends").settings.create(name: "Seeding Method", type_opt: "Manual,Random,MultiStage", description: "Select Seeding Method", vartype: 5, display_order: 4)
Game.find_by_name("League of Legends").settings.create(name: "Scheduling Method", type_opt: "Elimination,RoundRobin", description: "Select Scheduling Method", vartype: 5, display_order: 5)

Game.find_by_name("Chess").settings.create(name: "Time Control", description: "Enter a value for Time Control (ie. 5-5, 30, 6hr, or None)", vartype: 0, display_order: 1)
Game.find_by_name("Chess").settings.create(name: "Scoring Method", type_opt: "WinnerTakesAll", description: "Select Scoring Method", vartype: 5, display_order: 2)
Game.find_by_name("Chess").settings.create(name: "Seeding Method", type_opt: "Manual,Random,MultiStage", description: "Select Seeding Method", vartype: 5, display_order: 3)
Game.find_by_name("Chess").settings.create(name: "Scheduling Method", type_opt: "Elimination,RoundRobin", description: "Select Scheduling Method", vartype: 5, display_order: 4)

Game.find_by_name("Hearthstone").settings.create(name: "Deck Name", description: "Enter a name for your deck, be descriptive.", vartype: 1, display_order: 1)
Game.find_by_name("Hearthstone").settings.create(name: "Scoring Method", type_opt: "WinnerTakesAll", description: "Select Scoring Method", vartype: 5, display_order: 2)
Game.find_by_name("Hearthstone").settings.create(name: "Seeding Method", type_opt: "Manual,Random,MultiStage", description: "Select Seeding Method", vartype: 5, display_order: 3)
Game.find_by_name("Hearthstone").settings.create(name: "Scheduling Method", type_opt: "Elimination,RoundRobin", description: "Select Scheduling Method", vartype: 5, display_order: 4)

Game.find_by_name("Rock, Paper, Scissors").settings.create(name: "Favorite Object", description: "What is your favorite object in RPS?", type_opt: "Rock,Paper,Scissors", vartype: 2, display_order: 5)
Game.find_by_name("Rock, Paper, Scissors").settings.create(name: "Lizard, Spock allowed?", description: "Will you allow Lizard and Spock?", vartype: 4, display_order: 4)
Game.find_by_name("Rock, Paper, Scissors").settings.create(name: "Why are those up there even called radio buttons?", description: "Check boxes make sense at least", type_opt: "I do not know.,There is now spoon.,Wow.,Because electricity.,Wat?", vartype: 3, display_order: 6)
Game.find_by_name("Rock, Paper, Scissors").settings.create(name: "Scoring Method", type_opt: "WinnerTakesAll", description: "Select Scoring Method", vartype: 5, display_order: 1)
Game.find_by_name("Rock, Paper, Scissors").settings.create(name: "Seeding Method", type_opt: "Manual,Random,MultiStage", description: "Select Seeding Method", vartype: 5, display_order: 2)
Game.find_by_name("Rock, Paper, Scissors").settings.create(name: "Scheduling Method", type_opt: "Elimination,RoundRobin", description: "Select Scheduling Method", vartype: 5, display_order: 3)

if Rails.env.development?
	#user 1, the ADMIN
	User.create(name: "Administrator", user_name: "admin", email: "root@localhost.lan", password: "password", password_confirmation: "password", permissions: 0xFFFFFFFF)

	#john doe's for testing
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

	players_for_league = Array.new

	#users for our fake seeded game from the yamls
	players_for_league.push(User.create(name: "Sytrie", password: "password", email: "Sytrie@gmail.com", user_name: "Sytrie", password_confirmation: "password"))
	players_for_league.push(User.create(name: "Derpanator115", password: "password", email: "Derpanator115@gmail.com", user_name: "Derpanator115", password_confirmation: "password"))
	players_for_league.push(User.create(name: "Wlknexe56", password: "password", email: "Wlknexe56@gmail.com", user_name: "Wlknexe56", password_confirmation: "password"))
	players_for_league.push(User.create(name: "DVisionzz", password: "password", email: "DVisionzz@gmail.com", user_name: "DVisionzz", password_confirmation: "password"))
	players_for_league.push(User.create(name: "HYP3RTONIC", password: "password", email: "HYP3RTONIC@gmail.com", user_name: "HYP3RTONIC", password_confirmation: "password"))
	players_for_league.push(User.create(name: "M9Fumjaa", password: "password", email: "M9Fumjaa@gmail.com", user_name: "M9Fumjaa", password_confirmation: "password"))
	players_for_league.push(User.create(name: "spikevsnaruto", password: "password", email: "spikevsnaruto@gmail.com", user_name: "spikevsnaruto", password_confirmation: "password"))
	players_for_league.push(User.create(name: "GoogleMaSkills", password: "password", email: "GoogleMaSkills@gmail.com", user_name: "GoogleMaSkills", password_confirmation: "password"))
	players_for_league.push(User.create(name: "james chamberlan", password: "password", email: "jameschamberlan@gmail.com", user_name: "james chamberlan", password_confirmation: "password"))
	players_for_league.push(User.create(name: "Kaceytron", password: "password", email: "Kaceytron@gmail.com", user_name: "Kaceytron", password_confirmation: "password"))

	#semi-real users
	davis = User.create(name: "Davis Webb", password: "password", email: "davislwebb@gmail.com", user_name: "TeslasMind", password_confirmation: "password")
	foy = User.create(name: "Nathaniel Foy", password: "password", email: "nfoy@notreal.com", user_name: "Nalfeinx", password_confirmation: "password")
	guntas = User.create(name: "Guntas Grewal", password: "password", email: "guntasgrewal@gmail.com", user_name: "guntasgrewal", password_confirmation: "password")
	luke = User.create(name: "Luke Shumaker", password: "password", email: "lukeshu@emacs4lyfe.com", user_name: "lukeshu", password_confirmation: "password")
	tomer = User.create(name: "Tomer Kimia", password: "password", email: "tomer@2majors4lyfe.com", user_name: "tkimia", password_confirmation: "password")
	andrew = User.create(name: "Andrew Murrell", password: "password", email: "murrel@murrel.gov", user_name: "ImFromNasa", password_confirmation: "password")
	joey = User.create(name: "Joseph Adams", password: "password", email: "alpha142@fluttershyop.com", user_name: "alpha142", password_confirmation: "password")
	josh = User.create(name: "Josh Huser", password: "password", email: "jhuser@iownabusiness.net", user_name: "WinterWorks", password_confirmation: "password")
	dunsmore = User.create(name: "Professor Dunsmore", password: "password", email: "bxd@purdue.edu", user_name: "Dumbledore", password_confirmation: "password")
	marco = User.create(name: "Marco Polo", password: "password", email: "marco@ta4lyfe.com", user_name: "iCoordinate", password_confirmation: "password")
	jordan = User.create(name: "Geoffrey Webb", password: "password", email: "imnotjoffreybarathian@gameofthrones.com", user_name: "GTBPhoenix", password_confirmation: "password")
	obama = User.create(name: "Obama", password: "password", email: "obama@whitehouse.gov", user_name: "Obama", password_confirmation: "password")


	#league of legends tournament
	league_tourn = Tournament.create(game_id: 1, status: 0, name: "League of Legends Seed", min_players_per_team: 5, max_players_per_team: 5, min_teams_per_match: 2, 
		max_teams_per_match: 2, set_rounds: 1, randomized_teams: true, sampling_method: nil)

	#adds players to the seeded league tournament
	for i in 0..9
		if i == 0
			league_tourn.hosts.push(players_for_league[i])
		end
		league_tourn.join(players_for_league[i])
	end
	league_tourn.join(players_for_league[9])

	#chess
	chess_tourn = Tournament.create(game_id: 2, status: 0, name: "Chess Seed", min_players_per_team: 1, max_players_per_team: 1, min_teams_per_match: 2, 
		max_teams_per_match: 2, set_rounds: 1, randomized_teams: true, sampling_method: nil)

	chess_tourn.hosts.push(davis)
	chess_tourn.join(davis)
	chess_tourn.join(foy)

	#Rock Paper Scissors
	rps = Tournament.create(game_id: 4, status: 0, name: "Rock, Paper, Scissors Seed", min_players_per_team: 1, max_players_per_team: 3, min_teams_per_match: 2, 
		max_teams_per_match: 2, set_rounds: 1, randomized_teams: true, sampling_method: nil)

	rps.hosts.push(davis)
	rps.join(davis)
	rps.join(foy)
	rps.join(guntas)

	tourn5 = Tournament.create(game_id: 1, status: 0, name: "5 Teams, 2 Teams Per Match", min_players_per_team: 1, max_players_per_team: 1, min_teams_per_match: 2, 
		max_teams_per_match: 2, set_rounds: 1, randomized_teams: true, sampling_method: nil)

	for i in 0..9
		if i == 0
			tourn5.hosts.push(players_for_league[i])
		end
		tourn5.join(players_for_league[i])
	end
	tourn5.join(players_for_league[9])

end
