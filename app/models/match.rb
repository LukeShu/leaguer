class Match < ActiveRecord::Base
	belongs_to :tournament_stage
	has_many :scores
	has_and_belongs_to_many :teams

	belongs_to :winner, class_name: "Team"

	def setup()
		
	end

	def is_match_over(match, firstPlayer)
		#response = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/summoner/by-name/#{firstPlayer}?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		#riot_id = response["#{firstPlayer}"]['id']
		#recent game information
		#game_info = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{riot_id}/recent?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
		#first_id = game_info["games"][0]["gameId"]

		count = 0
		while true do 
			#sleep(5) #wait four minutes
			
			puts("Every 4 minutes.")
			puts("Every 4 minutes.")
			count += 1
			#game_info = HTTParty.get("https://prod.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{riot_id}/recent?api_key=ad539f86-22fd-474d-9279-79a7a296ac38")
			#current_id = game_info["games"][0]["gameId"]

			#if current_id != first_id
			if count > 2
				puts(count)
				#sleep(10)
				match.status = 2
				match.save
				return true
			end
		end #while
	end
	#handle_asynchronously :is_match_over
end
