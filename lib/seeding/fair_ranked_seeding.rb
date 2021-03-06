module Seeding
	module FairRankedSeeding
		def self.seed(tournament_stage)
			matches = tournament.current_stage.matches
			match = matches.first
			match_num = 0
			players_used = 0
			(tournament.players.count/tournament.min_players_per_team).floor.times do
				match.teams.push Team.create()
			end
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
		def self.best_first(tournament)
			tournament.players.sort {|a, b| better(a, b, tournament) }
		end

		def self.better(player1, player2, tournament)
			ps1 = previous_score(player1, tournament)
			ps2 = previous_score(player2, tournament)
			ps1 <=> ps2
		end

		def self.previous_score(player, tournament)
			score = tournament.statistics.where(match: player.matches.last, user: player, name: :score)
			if score.nil?
				return 0
			end
			score
		end
	end
end
