module Sampling
	class RiotApi
		protected
		def self.api_name
			"prod.api.pvp.net/api/lol"
		end

		protected
		def self.api_key
			ENV["RIOT_API_KEY"]
		end

		protected
		def self.region
			ENV["RIOT_API_REGION"]
		end

		protected
		def self.url(request, args={})
			"https://prod.api.pvp.net/api/lol/#{region}/#{request % args.merge(args){|k,v|url_escape(v)}}?#{api_key}"
		end

		protected
		def self.url_escape(string)
			URI::escape(string.to_s, /[^a-zA-Z0-9._~!$&'()*+,;=:@-]/)
		end

		protected
		def self.standardize(summoner_name)
			summoner_name.to_s.downcase.gsub(' ', '')
		end

		protected
		def self.stats_available
			["win", "numDeaths", "turretsKilled", "championsKilled", "minionsKilled", "assists"]
		end

		protected
		class Job < ThrottledApiRequest
			def initialize(request, args={})
					@url = Sampling::RiotApi::url(request, args)
					limits = [
						{:unit_time => 10.seconds, :requests_per => 10},
						{:unit_time => 10.minutes, :requests_per => 500},
					]
					super(api_name, limits)
			end

			def perform
				response = open(@url)
				status = response.status
				data = JSON::parse(response.read)

				# Error codes that RIOT uses:
				#   "400"=>"Bad request"
				#   "401"=>"Unauthorized"
				#   "429"=>"Rate limit exceeded"
				#   "500"=>"Internal server error"
				#   "503"=>"Service unavailable"
				#   "404"=>"Not found"
				# Should probably handle these better
				if status[0] != "200"
					raise "GET #{@url} => #{status.join(" ")}"
				end
				self.handle(data)
			end

			def handle(data)
			end
		end

		########################################################################

		##
		# Return whether or not this sampling method works with the specified game.
		# Spoiler: It only works with League of Legends (or subclasses of it).
		public
		def self.works_with?(game)
			if api_key.nil? or region.nil?
				return false
			end
			if game.name == "League of Legends"
				return true
			end
			unless game.parent.nil?
				return works_with?(game.parent)
			end
		end

		##
		# Return whether or not the API can get a given statistic for
		# a given user.
		public
		def self.can_get?(stat)
			if stats_available.include?(stat)
				return 2
			else
				return 0
			end
		end

		##
		# This sampling method uses remote IDs
		public
		def self.uses_remote?
			return true
		end

		##
		# When given a summoner name for a user, figure out the summoner ID.
		public
		def self.set_remote_name(user, game, summoner_name)
			Delayed::Job.enqueue(UsernameJob.new(user, game, summoner_name), :queue => api_name)
		end
		protected
		class UsernameJob < Job
			def initialize(user, game, summoner_name)
				@user_id = user.id
				@game_id = game.id
				# Escape any funny stuff
				summoner_names = [summoner_name].map{|name|Sampling::RiotApi::standardize(name.gsub(',',''))}
				# Generate the request
				super("v1.3/summoner/by-name/%{summonerNames}", { :summonerNames => summoner_names.join(",") })
			end
			def handle(data)
				user = User.find(@user_id)
				game = Game.find(@game_id)
				
				standardized_summoner_name = data.keys.first
				remote_data = {
					:id   => data[standardized_summoner_name]["id"],
					:name => data[standardized_summoner_name]["name"],
				}

				user.set_remote_username(game, remote_data)
			end
		end	

		##
		# When given data from RemoteUsername#value, give back a readable name to display.
		# Here, this is the summoner name.
		public
		def self.get_remote_name(data)
			data["name"]
		end

		####

		public
		def initialize(match)
			@match = match
		end

		##
		# Fetch all the statistics for a match.
		public
		def start
			@match.teams.each do |team|
				team.users.each do |user|
					#For demo purposes, we are hard coding in a league of legends game id.
					Delayed::Job.enqueue(MatchJob.new(user, @match, @match.stats_from(self.class), 1362730546), :queue => api_name)
				end
			end
		end
		protected
		class FetchStatisticsJob < Job
			def initialize(user, match, stats, last_game_id)
				@user_id = user.id
				@match_id = match.id
				@stats = stats
				@last_game_id = last_game_id

				# Get the summoner id
				summoner = user.get_remote_username(match.tournament_stage.tournament.game)
				# Generate the request
				super("v1.3/game/by-summoner/%{summonerId}/recent", { :summonerId => summoner["id"] })
			end
			def handle(data)
				user = User.find(@user_id)
				match = Match.find(@match_id)
				if @last_game_id.nil?
					Delayed::Job.enqueue(MatchJob.new(user, match, data["games"][0]["gameId"]), :queue => api_name)
				else
					if @last_game_id == data["games"][0]["gameId"]
						sleep(4.minutes)
						Delayed::Job.enqueue(MatchJob.new(user, match, @last_game_id), :queue => api_name)
					else
						@stats.each do |stat|
							Statistic.create(user: user, match: match, name: stat, value: data["games"][0]["stats"][stat])
						end
					end
				end
			end
		end

		public
		def render_user_interaction(user)
			return ""
		end

		public
		def handle_user_interaction(user)
			# do nothing
		end
	end
end
