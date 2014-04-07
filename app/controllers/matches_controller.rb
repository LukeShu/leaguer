class MatchesController < ApplicationController
	before_action :set_tournament, only: [:index]

	# GET /matches
	# GET /matches.json
  require 'httparty'
  require 'json'
  require 'delayed_job'

  def index
    @matches = @tournament.matches
    # width of SVG
    @width = 300 * (Math.log2(@matches.count).floor + 1);
    # height of SVG
    @height = 200 * 2**Math.log2(@matches.count).floor + 100;
  end



  def get_riot_info
	if signed_in?

			#current user information
			response = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/by-name/#{current_user.user_name}?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")

			id = response["#{current_user.user_name.downcase}"]['id']

			#recent game information
			recent = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{response["#{current_user.user_name.downcase}"]['id']}/recent?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")

			game_id = recent["games"][0]["gameId"]

			#remote_user_id = 6651654651354
			#remove_user_name = TeslasMind
			#How to Add
			#how do I access

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

	end #end if
  end #end def
	# GET /matches/1
	# GET /matches/1.json

	def is_match_over
		response = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/by-name/#{@first}?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		riot_id = response["#{@first}"]['id']
		#recent game information
		game_info = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{riot_id}/recent?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		first_id = game_info["games"][0]["gameId"]

		while true do 
			sleep(240) #wait four minutes

			recent = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{riot_id}/recent?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
			current_id = recent["games"][0]["gameId"]

			if current_id != first_id
				@match.status = 2
			end
		end #while
	end
	handle_asynchronously :is_match_over

	def show
		if @match.id == 1
			is_match_over
		end


	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_match
		set_tournament
		@match = @tournament.matches.find(params[:id])
		@first = @match.teams.first.users.first.user_name.downcase
	end
	def set_tournament
		@tournament = Tournament.find(params[:tournament_id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def match_params
		params.require(:match).permit(:status, :tournament_id, :name, :winner_id, :remote_id)
	end
end
