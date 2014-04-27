module Seeding
	class FairRankedSeeding
		def seed_matches(tournament)
			matches = tournament.current_stage.matches
			match = matches.first
			match_num = 0
			players_used = 0
			best_first(tournament).each_slice(tournament.min_teams_per_match) do |slice|
				(0..tournament.min_teams_per_match-1).each do |index|
					match.teams[index].players += slice[index]
				end
				players_used += 1
				if players_used == tournament.min_players_per_team
					match_num += 1
					match = matches[match_num]
					players_used = 0
				end
			end
		end

		private
		def best_first(tournament)
			tournament.players.sort {|a, b| better(a, b, tournament) }
		end

		def better(player1, player2, tournament)
			ps1 = previousScore(player1, tournament)
			ps2 = previousScore(player2, tournament)
			if ps1 > ps2
				return 1
			elsif ps2 > ps1
				return -1
			else
				return 0
			end
		end

		def previousScore(player, tournament)
			score = tournament.statistics.getStatistic(player.matches.last, player, :score)
			if score.nil?
				return 0
			end
			score
		end
	end
end