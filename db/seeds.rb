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

league = Game.create(name: "League of Legends", min_players_per_team: 5,  max_players_per_team: 5, min_teams_per_match: 2, max_teams_per_match: 2)
league.settings.create(display_order: 1, name: "map"      , description: "Select a map to play on.", vartype: GameSetting::types[:pick_one_dropdown], type_opt: "summoners_rift,twisted_treeline,crystal_scar,haunted_abyss", default: "summoners_rift")
league.settings.create(display_order: 2, name: "pick_type", description: "Select a pick type."     , vartype: GameSetting::types[:pick_one_dropdown], type_opt: "blind_pick,draft"                                          , default: "draft")

chess = Game.create(name: "Chess", min_players_per_team: 1,  max_players_per_team: 1, min_teams_per_match: 2, max_teams_per_match: 2)
chess.settings.create(display_order: 1, name: "time_control", description: "Enter a value for Time Control (ie. 5-5, 30, 6hr, or None)", vartype: GameSetting::types[:text_short], default: "")

hearthstone = Game.create(name: "Hearthstone", min_players_per_team: 1, max_players_per_team: 1, min_teams_per_match: 2, max_teams_per_match: 2)
hearthstone.settings.create(display_order: 1, name: "deck_name", description: "Enter a name for your deck, be descriptive.", vartype: GameSetting::types[:text_long], default: "")

rockpaperscissors = Game.create(name: "Rock, Paper, Scissors", min_players_per_team: 1, max_players_per_team: 3, min_teams_per_match: 2, max_teams_per_match: 2)
rockpaperscissors.settings.create(display_order: 4, name: "lizard_spock_allowed", description: "Will you allow Lizard and Spock?"    , vartype: GameSetting::types[:true_false]    , default: false)
rockpaperscissors.settings.create(display_order: 5, name: "favorite_object"     , description: "What is your favorite object in RPS?", vartype: GameSetting::types[:pick_one_radio], type_opt: "rock,paper,scissors", default: "rock")
rockpaperscissors.settings.create(display_order: 6, name: "check_boxes"         , description: "Example boxes"                       , vartype: GameSetting::types[:pick_several]  , type_opt: "i_do_not_know,there_is_now_spoon,wow,because_electricity,wat?", default: "wow,wat?")

if Rails.env.development?
	# User 1, the ADMIN
	User.create(name: "Administrator", user_name: "admin", email: "root@localhost.lan", password: "password", password_confirmation: "password", permissions: 0xFFFFFFFF)

	# John Doe's for testing
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

	# Users for mocked Riot API calls
	players_for_league = []
	players_for_league.push(User.create(name: "Sytrie"          , password: "password", email: "Sytrie@gmail.com"         , user_name: "Sytrie"          , password_confirmation: "password"))
	players_for_league.push(User.create(name: "Derpanator115"   , password: "password", email: "Derpanator115@gmail.com"  , user_name: "Derpanator115"   , password_confirmation: "password"))
	players_for_league.push(User.create(name: "Wlknexe56"       , password: "password", email: "Wlknexe56@gmail.com"      , user_name: "Wlknexe56"       , password_confirmation: "password"))
	players_for_league.push(User.create(name: "DVisionzz"       , password: "password", email: "DVisionzz@gmail.com"      , user_name: "DVisionzz"       , password_confirmation: "password"))
	players_for_league.push(User.create(name: "HYP3RTONIC"      , password: "password", email: "HYP3RTONIC@gmail.com"     , user_name: "HYP3RTONIC"      , password_confirmation: "password"))
	players_for_league.push(User.create(name: "M9Fumjaa"        , password: "password", email: "M9Fumjaa@gmail.com"       , user_name: "M9Fumjaa"        , password_confirmation: "password"))
	players_for_league.push(User.create(name: "spikevsnaruto"   , password: "password", email: "spikevsnaruto@gmail.com"  , user_name: "spikevsnaruto"   , password_confirmation: "password"))
	players_for_league.push(User.create(name: "GoogleMaSkills"  , password: "password", email: "GoogleMaSkills@gmail.com" , user_name: "GoogleMaSkills"  , password_confirmation: "password"))
	players_for_league.push(User.create(name: "james chamberlan", password: "password", email: "jameschamberlan@gmail.com", user_name: "james chamberlan", password_confirmation: "password"))
	players_for_league.push(User.create(name: "Kaceytron"       , password: "password", email: "Kaceytron@gmail.com"      , user_name: "Kaceytron"       , password_confirmation: "password"))

	# Semi-real users
	guntas   = User.create(name: "Guntas Grewal"     , password: "password", email: "guntasgrewal@gmail.com"                 , user_name: "guntasgrewal", password_confirmation: "password")
	luke     = User.create(name: "Luke Shumaker"     , password: "password", email: "lukeshu@emacs4lyfe.com"                 , user_name: "lukeshu"     , password_confirmation: "password")
	tomer    = User.create(name: "Tomer Kimia"       , password: "password", email: "tomer@2majors4lyfe.com"                 , user_name: "tkimia"      , password_confirmation: "password")
	josh     = User.create(name: "Josh Huser"        , password: "password", email: "jhuser@iownabusiness.net"               , user_name: "WinterWorks" , password_confirmation: "password")
	dunsmore = User.create(name: "Professor Dunsmore", password: "password", email: "bxd@purdue.edu"                         , user_name: "Dumbledore"  , password_confirmation: "password")
	marco    = User.create(name: "Marco Polo"        , password: "password", email: "marco@ta4lyfe.com"                      , user_name: "iCoordinate" , password_confirmation: "password")
	jordan   = User.create(name: "Geoffrey Webb"     , password: "password", email: "imnotjoffreybarathian@gameofthrones.com", user_name: "GTBPhoenix"  , password_confirmation: "password")
	obama    = User.create(name: "Obama"             , password: "password", email: "obama@whitehouse.gov"                   , user_name: "Obama"       , password_confirmation: "password")

	g = Array.new

	davis         = User.create(name: "Davis Webb"        , password: "password", email: "davislwebb@gmail.com"         , user_name: "TeslasMind"         , password_confirmation: "password")
	foy           = User.create(name: "Nathaniel Foy"     , password: "password", email: "nfoy@purdue.edu"              , user_name: "NalfeinX"           , password_confirmation: "password")
	andrew        = User.create(name: "Andrew Murrell"    , password: "password", email: "murrel@murrel.gov"            , user_name: "ImFromNasa"         , password_confirmation: "password")
	joey          = User.create(name: "Joseph Adams"      , password: "password", email: "alpha142@fluttershyop.com"    , user_name: "alpha142"           , password_confirmation: "password")
	panda 	      = User.create(name: "Panda"        	  , password: "password", email: "panda@gmail.com"              , user_name: "InspectorPanderp"   , password_confirmation: "password")
	mesa 	      = User.create(name: "Mesataki"          , password: "password", email: "mesataki@gmail.com"           , user_name: "Mesataki"           , password_confirmation: "password")
	guntas_league = User.create(name: "TolkiensButt"      , password: "password", email: "TolkiensButt@gmail.com"       , user_name: "TolkiensButt"       , password_confirmation: "password")
	lyra          = User.create(name: "Lyra Heartstings"  , password: "password", email: "LyraHeartstings@gmail.com"    , user_name: "Lyra Heartstings"   , password_confirmation: "password")
	josh_league   = User.create(name: "Josh_league"       , password: "password", email: "josh_league@gmail.com"        , user_name: "Joshoowah"          , password_confirmation: "password")
	jeff 		  = User.create(name: "Jeff Linguinee"    , password: "password", email: "jefflingueeneeeee@gmail.com"  , user_name: "SenorJeffafa"       , password_confirmation: "password")
	sarah         = User.create(name: "Sarah Lawson"      , password: "password", email: "sarah@gmail.com"              , user_name: "LittlexSurah"       , password_confirmation: "password")


	# League of Legends tournament
	league_tourn = Tournament.create(game: league, name: "League of Legends Seed",
		min_players_per_team: 5, max_players_per_team: 5,
		min_teams_per_match: 2, max_teams_per_match: 2,
		scoring_method: "winner_takes_all")

	league_tourn.stages.create(scheduling_method: "round_robin" , seeding_method: "random_seeding")

	league_tourn.hosts.push(User.find(1))
	players_for_league.each do |player|
		league_tourn.join(player)
	end

	# Chess
	chess_tourn = Tournament.create(game: chess, name: "Chess Seed",
		min_players_per_team: 1, max_players_per_team: 1,
		min_teams_per_match: 2, max_teams_per_match: 2,
		scoring_method: "winner_takes_all")

	chess_tourn.stages.create(scheduling_method: "round_robin" , seeding_method: "random_seeding")

	chess_tourn.hosts.push(davis)
	chess_tourn.join(davis)
	chess_tourn.join(foy)

	# Rock Paper Scissors
	rps = Tournament.create(game: rockpaperscissors, name: "Rock, Paper, Scissors Seed",
		min_players_per_team: 1, max_players_per_team: 3,
		min_teams_per_match: 2, max_teams_per_match: 2,
		scoring_method: "winner_takes_all")
	rps.stages.create(scheduling_method: "round_robin" , seeding_method: "random_seeding")
	rps.hosts.push(davis)
	rps.join(davis)
	rps.join(foy)
	rps.join(guntas)

	# Another League tournament
	tourn5 = Tournament.create(game: league, name: "5 Teams, 2 Teams Per Match",
		min_players_per_team: 1, max_players_per_team: 1,
		min_teams_per_match: 2, max_teams_per_match: 2,
		scoring_method: "winner_takes_all")
	tourn5.hosts.push(User.find(1))
	players_for_league.each do |player|
		tourn5.join(player)
	end
	tourn5.stages.create(scheduling_method: "elimination" , seeding_method: "random_seeding")

	# Yet another League tournament
	tourn6 = Tournament.create(game_id: 1, name: "3 teams per match",
		min_players_per_team: 1, max_players_per_team: 1,
		min_teams_per_match: 3, max_teams_per_match: 3,
		scoring_method: "winner_takes_all")

	tourn6.hosts.push(User.find(1))
	tourn6.stages.create(scheduling_method: "round_robin" , seeding_method: "random_seeding")
	players_for_league.each do |player|
		tourn6.join(player)
	end
	tourn6.join(davis)
	tourn6.join(foy)
	tourn6.join(guntas)
	tourn6.join(luke)
	tourn6.join(marco)
	tourn6.join(jordan)
	tourn6.join(obama)
	tourn6.join(joey)

	#Hearthstone tournament
	hearth = Tournament.create(game: hearthstone, name: "Hearthstone Seed", min_teams_per_match: 1, min_players_per_team: 1, 
	                           max_teams_per_match: 2, max_players_per_team: 1, scoring_method: "winner_takes_all")
	hearth.hosts.push(User.find(1))

	hearth.join(davis)
	hearth.join(foy)

	hearth.stages.create(scheduling_method: "round_robin" , seeding_method: "random_seeding")

	#THE REAL GAME WE ARE PLAYING AT 10
	davis.remote_usernames.create(game: league, value: {"name" => "TeslasMind", "id" => 30533514} )
	foy.remote_usernames.create(game: league, value: {"name" => "NalfeinX", "id" => 29538130} )
	andrew.remote_usernames.create(game: league, value: {"name" => "ImFromNasa", "id" => 29782091} )
	joey.remote_usernames.create(game: league, value: {"name" => "Alpha142", "id" => 29732514} )
	sarah.remote_usernames.create(game: league, value: {"name" => "LittlexSurah", "id" => 30613787} )
	mesa.remote_usernames.create(game: league, value: {"name" => "Mesataki", "id" => 37259275} )
	panda.remote_usernames.create(game: league, value: {"name" => "NalfeinX", "id" => 47953989} )
	jordan.remote_usernames.create(game: league, value: {"name" => "GTBPhoenix", "id" => 29812020} )
	josh_league.remote_usernames.create(game: league, value: {"name" => "Joshoowah", "id" => 26083333} )
	jeff.remote_usernames.create(game: league, value: {"name" => "SenorJeffafa", "id" => 32612067} )
	lyra.remote_usernames.create(game: league, value: {"name" => "Lyra Heartstings", "id" => 32240762} )

	g.push(davis, joey, panda, mesa, josh_league, jordan, jeff, sarah, foy, andrew)

	custom = Tournament.create(game: league, name: "Real League Game",
		min_players_per_team: 5, max_players_per_team: 5,
		min_teams_per_match: 2, max_teams_per_match: 2,
		scoring_method: "winner_takes_all")

	custom.hosts.push(User.find(1))

	custom.stages.create(scheduling_method: "round_robin" , seeding_method: "early_bird_seeding")


	custom.hosts.push(User.find(1))
	g.each do |player|
		custom.join(player)
	end
end