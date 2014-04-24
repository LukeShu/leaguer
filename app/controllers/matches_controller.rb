class MatchesController < ApplicationController
	require 'httparty'
	require 'json'
	require 'delayed_job'

	before_action :set_tournament, only: [:index]

	# GET /tournaments/1/matches
	# GET /tournaments/1/matches.json
	def index
	end

	# For compatability with the router assumptions made by ApplicationController#check_permission
	def matches_url
		set_tournament
		tournament_matches_path(@tournament)
	end

	def get_riot
		
		players_id = Array.new		
		players = Array.new

		@match.teams.each do |team|
			team.users.each do |user|
				players_id.push(user.remote_usernames[0]["json_value"]["id"])
				players.push(user.remote_usernames[0]["json_value"]["id"])
			end
		end

		recent = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{players_id[0]}/recent?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")

		blue = Hash.new
		purple = Hash.new

		for i in 0..8
			current_player = players_id[i]
			place = players[i]
			info = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{current_player}/recent?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")

			if 100 == info["games"][0]["stats"]["team"]
				blue.merge!("#{place}" => info["games"][0]["stats"])
			else
				purple.merge!("#{place}" => info["games"][0]["stats"])
			end
			sleep(1)
		end

		#look into this glitch
		if 100 == recent["games"][0]["stats"]["team"]
			blue.merge!("#{players[9]}" => recent["games"][0]["stats"])
		else
			purple.merge!("#{players[9]}" => recent["games"][0]["stats"])
		end

		@purp = purple
		@blue = blue

	end

	def get_riot_info_fake
		pull = "Kaceytron"
		#current user information
		response = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/by-name/#{pull.downcase}?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")

		id = response["#{pull.downcase}"]['id']

		#recent game information
		recent = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{response["#{pull.downcase}"]['id']}/recent?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")

		game_id = recent["games"][0]["gameId"]

		#members of most recent game id's
		player1 = recent["games"][0]["fellowPlayers"][0]["summonerId"]
		player2 = recent["games"][0]["fellowPlayers"][1]["summonerId"]
		player3 = recent["games"][0]["fellowPlayers"][2]["summonerId"]
		player4 = recent["games"][0]["fellowPlayers"][3]["summonerId"]
		player5 = recent["games"][0]["fellowPlayers"][4]["summonerId"]
		player6 = recent["games"][0]["fellowPlayers"][5]["summonerId"]
		player7 = recent["games"][0]["fellowPlayers"][6]["summonerId"]
		player8 = recent["games"][0]["fellowPlayers"][7]["summonerId"]
		player9 = recent["games"][0]["fellowPlayers"][8]["summonerId"]

		players_by_id = [player1, player2, player3, player4, player5, player6, player7, player8, player9]

		#collect summoner names
		memb1 = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/#{player1}/name?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		memb1 = memb1["#{player1}"]
		sleep(1);

		memb2 = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/#{player2}/name?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		memb2 = memb2["#{player2}"]
		sleep(1);

		memb3 = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/#{player3}/name?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		memb3 = memb3["#{player3}"]
		sleep(1);

		memb4 = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/#{player4}/name?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		memb4 = memb4["#{player4}"]
		sleep(1);

		memb5 = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/#{player5}/name?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		memb5 = memb5["#{player5}"]
		sleep(1);

		memb6 = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/#{player6}/name?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		memb6 = memb6["#{player6}"]
		sleep(1);

		memb7 = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/#{player7}/name?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		memb7 = memb7["#{player7}"]
		sleep(1);

		memb8 = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/#{player8}/name?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		memb8 = memb8["#{player8}"]
		sleep(1);

		memb9 = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/#{player9}/name?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		memb9 = memb9["#{player9}"]
		sleep(1);

		memb10 = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/#{id}/name?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		memb10 = memb10["#{id}"]

		players = ["#{memb1}", "#{memb2}", "#{memb3}", "#{memb4}", "#{memb5}", "#{memb6}", "#{memb7}", "#{memb8}", "#{memb9}", "#{memb10}"]

		sleep(5);

		blue = Hash.new
		purple = Hash.new

		for i in 0..8
			current_player = players_by_id[i]
			place = players[i]
			info = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{current_player}/recent?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")

			if 100 == info["games"][0]["stats"]["team"]
				blue.merge!("#{place}" => info["games"][0]["stats"])
			else
				purple.merge!("#{place}" => info["games"][0]["stats"])
			end
			sleep(1)
		end

		if 100 == recent["games"][0]["stats"]["team"]
			blue.merge!("#{players[9]}" => recent["games"][0]["stats"])
		else
			purple.merge!("#{players[9]}" => recent["games"][0]["stats"])
		end

		@purp = purple
		@blue = blue

	end #end def

	# GET /tournaments/1/matches/1
	# GET /tournaments/1/matches/1.json
	def show
		if @match.tournament_stage.tournament.game_id == 1
			file_blue = "blue.yaml"
			file_purple = "purple.yaml"
			@blue2 = YAML.load_file(file_blue)
			@purp2 = YAML.load_file(file_purple)
		end
	end

	# PATCH/PUT /tournaments/1/matches/1
	# PATCH/PUT /tournaments/1/matches/1.json
	def update
		case params[:update_action]
		when "start"
			@match.status = 1
			respond_to do |format|
				if @match.save
					format.html { redirect_to tournament_match_path(@tournament, @match), notice: 'Match has started.' }
					format.json { head :no_content }
				else
					format.html { redirect_to @tournament, notice: "You don't have permission to start this match." }
					format.json { render json: "Permission denied", status: :forbidden }
				end
			end
		when "finish"

			#make this use the statistics interface for scoring and ScoringAlgorithms



			# Individual scores
			scores = params["scores"]
			scores.each do |user_name, score|
				Statistic.create(user: User.find_by_user_name(user_name), match: @match, name: "score", value: score.to_i)
			end

			# Team scores (processing for manual)
			team_scores = {}
			@match.teams.each do |team|
				team_scores[team] = 0
				team.users.each do |user|
					team_scores[team] += scores[user.user_name].to_i
				end
			end
			teams = team_scores.invert
			@match.winner = teams[teams.keys.sort.last]

			# Schedule next match
			#cur_match_num = @tournament.matches_ordered.invert[@match]
			#unless cur_match_num == 1
			#	@match.winner.matches.push(@tournament.matches_ordered[cur_match_num/2])
			#end

			# Skip peer evaluation if there aren't enough players per team
			peer = false
			@match.teams.each do |team|
				if team.users.count > 2
					peer = true
				end
			end
			@match.status = peer ? 2 : 3

			respond_to do |format|
				if @match.save
					format.html { redirect_to tournament_match_path(@tournament, @match), notice: 'Peer evaluation started.' }
					format.json { head :no_content }
				else
					format.html { redirect_to @tournament, notice: "You don't have permission to start this match." }
					format.json { render json: "Permission denied", status: :forbidden }
				end
			end		
		when "peer"
			order = params[:review_action]
			base_score = 2
			next_score = 3
			order.split(",").reverse.each do |elem|
				player_score = base_score
				if @match.winner.user.include?(@current_user)
					player_score += 10
				else
					player_score += 7
				end
				Score.create(user: elem, match: @match, value: player_score )
				base_score = next_score
				next_score += base_score  
			end
			@match.submitted_peer_evaluations += 1
			players = []; @match.teams.each{|t| players.concat(t.users.all)}
			if (@match.submitted_peer_evaluations == players.count) 
				@match.status = 3
			end
			respond_to do |format|
				if @match.save
					format.html { redirect_to tournament_match_path(@tournament, @match), notice: 'Scores Submitted' }
					format.json { head :no_content }
				else
					format.html { redirect_to @tournament, notice: "You don't have permission to start this match." }
					format.json { render json: "Permission denied", status: :forbidden }
				end
			end
		when "reset"
			@match.status = 0
			respond_to do |format|
				if @match.save
					format.html { redirect_to tournament_match_path(@tournament, @match), notice: 'Match Status Reset to 0' }
					format.json { head :no_content }
				else
					format.html { redirect_to @tournament, notice: "You don't have permission to start this match." }
					format.json { render json: "Permission denied", status: :forbidden }
				end
			end
		else
			respond_to do |format|
				format.html { redirect_to @tournament, notice: "Invalid action", status: :unprocessable_entity }
				format.json { render json: @tournament.errors, status: :unprocessable_entity }
			end
		end

	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_match
		@match = Match.find(params[:id])
		@tournament = @match.tournament_stage.tournament
	end
	def set_tournament
		@tournament = Tournament.find(params[:tournament_id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def match_params
		params.require(:match).permit(:status, :tournament_stage_id, :winner_id, :remote_id, :submitted_peer_evaluations, :update_action)
	end

		# Turn of check_edit, since our #update is flexible
	def check_edit
		set_match
	end
end
