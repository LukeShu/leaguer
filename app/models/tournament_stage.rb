class TournamentStage < ActiveRecord::Base
	belongs_to :tournament
	has_many :matches

	def matches_ordered
		h = {}
		i = 1
		self.matches.order(:id).each do |m|
			h[i] = m
			i += 1
		end
		return h
	end

	def create_matches
		set_scheduling
		@scheduling.create_matches
	end

	def to_svg(current_user)
		set_scheduling
		return @scheduling.graph(current_user)
	end

	def pair
		set_pairing
		return @pairing.pair(matches, players)
	end

	def score
		set_scoring
		#populating the user scores in the database form what you get from @scoring.score(match, interface)
	end

	#populate the statistics interface (with populating method)
	def populate
		set_populating
		#?
	end

	private
	def set_scheduling
		if @scheduling.nil?
			require "scheduling/#{self.scheduling}"
			@scheduling = "Scheduling::#{self.scheduling.capitalize}".constantize.new(self)
		end
		return @scheduling
	end

	private
	def set_pairing
		if @pairing.nil?
			if(@tournament.randomized_teams)
				require "pairing/#{self.pairing}"
				@pairing = "Pairing::RandomPairing"
				return @pairing
			#elsif(setTeams)
				#@pairing = Pre built
				#return @pairing
			end
		end
	end

	private
	def set_scoring
	end

	private
	def set_populating
	end
end
