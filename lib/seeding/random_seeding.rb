module Seeding
	class RandomSeeding
		def seed(tournament_stage)
			matches = tournament.current_stage.matches
			match = matches.first
			match_num = 0
			teams = 0
			tournament.players.shuffle.each_slice(tournament.min_players_per_team) do |slice|
				if teams < tournament.min_teams_per_match
					match.teams[teams].players += slice
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