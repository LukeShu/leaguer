
module Scheduling
	class RoundRobin
		include Rails.application.routes.url_helpers

		def initialize(tournament_stage)
			@tournament_stage = tournament_stage
		end

		def create_matches
			num_teams = (self.tournament.players.count/self.tournament.min_players_per_team).floor
			num_matches = Float(num_teams/2)*(num_teams-1)

		end

		def match_finished(match)
			
		end

		def graph(current_user)
			
		end
	end
end
