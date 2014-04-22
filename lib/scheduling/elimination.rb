module Scheduling
	class Elimination

		def initialize(tournament_stage)
			@tournament_stage = tournament_stage
		end

		def tournament_stage
			@tournament_stage
		end
		def tournament
			self.tournament_stage.tournament
		end

		def create_matches
			num_teams = (self.tournament.players.count/self.tournament.min_players_per_team).floor
			num_matches = num_teams - 1
			for i in 1..num_matches
				self.tournament_stage.matches.create(status: 0, submitted_peer_evaluations: 0)
			end
			match_num = num_matches-1
			team_num = 0
			# for each grouping of min_players_per_team
			self.tournament.players.each_slice(min_players_per_team) do |team_members|
				# if the match is full, move to the next match, otherwise move to the next team
				if (team_num == min_teams_per_match)
					match_num -= 1
					team_num = 0
				else
					team_num += 1
				end
				# create a new team in the current match
				self.tournament_stage.matches[match_num].teams.push(Team.create(users: team_members))
			end
		end

		def match_finished(match)
			matches = match.tournament_stage.matches_ordered
			cur_match_num = matches.invert[match]
			unless cur_match_num == 1
				match.winner.matches.push(matches[cur_match_num/2])
			end
		end

		def graph
			require 'erb'
			erb_filename = File.join(File.dirname(__FILE__), 'elimination.svg.erb')

			erb = ERB.new(File.read(erb_filename))
			erb.filename = erb_filename
			return erb.result
		end

	end
end
