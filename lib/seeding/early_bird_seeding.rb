module Seeding
	module EarlyBirdSeeding
		def self.seed(tournament_stage)
		matches = tournament_stage.matches
			match = matches.first
			match_num = 0
			teams = 0
			tournament_stage.tournament.players.each_slice(tournament_stage.tournament.min_players_per_team) do |slice|
				if teams < tournament_stage.tournament.min_teams_per_match
					match.teams.push Team.create(players: slice)
					teams += 1
				else
					match_num += 1
					match = matches[match_num]
					teams = 0
				end
			end
		end
	end
end
