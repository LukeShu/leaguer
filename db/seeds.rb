# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
p = User.permission_bits
Server.create(default_user_permissions: p[:join_tournament] | p[:create_pm] | p[:edit_pm] | p[:create_bracket])

league = Game.create(name: "League of Legends", min_players_per_team: 5,  max_players_per_team: 5, min_teams_per_match: 2, max_teams_per_match: 2, sampling_method: "riot_api")
league.settings.create(display_order: 1, name: "Map"      , description: "Select a map to play on.", vartype: GameSetting::types[:pick_one_dropdown], type_opt: "Summoners Rift,Twisted Treeline,Crystal Scar,Haunted Abyss", default: "Summoners Rift")
league.settings.create(display_order: 2, name: "Pick type", description: "Select a pick type."     , vartype: GameSetting::types[:pick_one_dropdown], type_opt: "Blind pick,Draft"                                          , default: "Draft")

chess = Game.create(name: "Chess", min_players_per_team: 1,  max_players_per_team: 1, min_teams_per_match: 2, max_teams_per_match: 2, sampling_method: "Manual,Double Blind")
chess.settings.create(display_order: 1, name: "Time Control", description: "Enter a value for Time Control (ie. 5-5, 30, 6hr, or None)", vartype: GameSetting::types[:text_short], default: "")

hearthstone = Game.create(name: "Hearthstone", min_players_per_team: 1, max_players_per_team: 1, min_teams_per_match: 2, max_teams_per_match: 2, sampling_method: "Manual,Double Blind")
hearthstone.settings.create(display_order: 1, name: "Deck name", description: "Enter a name for your deck, be descriptive.", vartype: GameSetting::types[:text_long], default: "")

rockpaperscissors = Game.create(name: "Rock, Paper, Scissors", min_players_per_team: 1, max_players_per_team: 3, min_teams_per_match: 2, max_teams_per_match: 2, sampling_method: "Manual,Double Blind")
rockpaperscissors.settings.create(display_order: 4, name: "Lizard/Spock allowed?", description: "Will you allow Lizard and Spock?"    , vartype: GameSetting::types[:true_false]    , default: false)
rockpaperscissors.settings.create(display_order: 5, name: "Favorite object"      , description: "What is your favorite object in RPS?", vartype: GameSetting::types[:pick_one_radio], type_opt: "Rock,Paper,Scissors", default: "Rock")
rockpaperscissors.settings.create(display_order: 6, name: "Check boxes"          , description: "Example boxes"                       , vartype: GameSetting::types[:pick_several]  , type_opt: "I do not know,There is now spoon,Wow,Because electricity,Wat?", default: "Wow,Wat?")

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
		max_teams_per_match: 2, sampling_method: nil)

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
		max_teams_per_match: 2, sampling_method: nil)

	chess_tourn.hosts.push(davis)
	chess_tourn.join(davis)
	chess_tourn.join(foy)

	#Rock Paper Scissors
	rps = Tournament.create(game_id: 4, status: 0, name: "Rock, Paper, Scissors Seed", min_players_per_team: 1, max_players_per_team: 3, min_teams_per_match: 2, 
		max_teams_per_match: 2, sampling_method: nil)

	rps.hosts.push(davis)
	rps.join(davis)
	rps.join(foy)
	rps.join(guntas)

	tourn5 = Tournament.create(game_id: 1, status: 0, name: "5 Teams, 2 Teams Per Match", min_players_per_team: 1, max_players_per_team: 1, min_teams_per_match: 2, 
		max_teams_per_match: 2, sampling_method: nil)

	for i in 0..9
		if i == 0
			tourn5.hosts.push(players_for_league[i])
		end
		tourn5.join(players_for_league[i])
	end
	tourn5.join(players_for_league[9])

	tourn6 = Tournament.create(game_id: 1, status: 0, name: "3 teams per match", min_players_per_team: 1, max_players_per_team: 1, min_teams_per_match: 3, 
		max_teams_per_match: 3, sampling_method: nil)

	for i in 0..9
		if i == 0
			tourn6.hosts.push(players_for_league[i])
		end
		tourn6.join(players_for_league[i])
	end
	tourn6.join(players_for_league[9])
	tourn6.join(davis)
	tourn6.join(foy)
	tourn6.join(guntas)
	tourn6.join(luke)
	tourn6.join(marco)
	tourn6.join(jordan)
	tourn6.join(obama)
	tourn6.join(joey)


=begin
	hash1 = {:username => "TeslasMind", :id => id}
	hash2 = {:username => "Alpha142", :id => id}
	hash3 = {:username => "ImFromNasa", :id => id}
	hash4 = {:username => "NalfeinX", :id => id}
	hash5 = {:username => "GTBPhoenix", :id => id}
	hash6 = {:username => , :id => id}
	hash7 = {:username => username, :id => id}
	hash8 = {:username => username, :id => id}
	hash9 = {:username => username, :id => id}
	hash10 = {:username => username, :id => id}



FOR ROUNG ROBIN

http://stackoverflow.com/questions/6648512/scheduling-algorithm-for-a-round-robin-tournament


=end

end
