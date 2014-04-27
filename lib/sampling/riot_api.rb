module Sampling
	module RiotApi
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
		class Job < ThrottledApiRequest
			def initialize(request, args={})
					@url = Sampling::RiotApi::url(request, args)
					super(api_name, 10.seconds, 10)
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
				
				normalized_summoner_name = data.keys.first
				remote_data = {
					:id   => data[normalized_summoner_name]["id"],
					:name => data[normalized_summoner_name]["name"],
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

		##
		# Fetch all the statistics for a match.
		public
		def self.sampling_start(match)
			@match.teams.each do |team|
				team.users.each do |user|
					Delayed::Job.enqueue(MatchJob.new(user, match), :queue => api_name)
				end
			end
		end
		protected
		class FetchStatisticsJob < Job
			def initialize(user, match)
				@user_id = user.id
				@match_id = match.id
				# Get the summoner id
				summoner = user.get_remote_username(match.tournament_stage.tournament.game)
				if summoner.nil?
					raise "Someone didn't enter their summoner name"
				end
				# Generate the request
				super("v1.3/game/by-summoner/%{summonerId}/recent", { :summonerId => summoner["id"] })
			end
			def handle(data)
				user = User.find(@user_id)
				match = Match.find(@match_id)
				Statistic.create(user: user, match: match, value: TODO)
			end
		end

		public
		def self.sampling_done?(match)
			# TODO
		end

		public
		def self.render_user_interaction(match, user)
			return ""
		end

		public
		def self.handle_user_interaction(match, user)
		end
	end
end