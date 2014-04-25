module Scheduling
	class RoundRobin
		include Rails.application.routes.url_helpers

		def initialize(tournament_stage)
			@tournament_stage = tournament_stage
		end

		def create_matches
			num_teams = (self.tournament.players.count/self.tournament.min_players_per_team).floor
			num_matches = Float(num_teams/2)*(num_teams-1)

			#round robin should look like this
			@team_pairs = Array.new(num_matches)
			for i in 0..@match.teams.size
				@team_pairs.push(@match.teams[i]
			end
			#team_pairs needs populated with the team objects and im not sure how to do that
		end

		#this is called when a round has completed
		def rotate
						
			for i in 0..@team_pairs-2
				hold = @team_pairs.shift
				@team_pairs.rotate!
				@team_pairs.unshift(hold)
			#	for j in 0..4
			#		puts "#{array[j]}, #{array[j+(array.size/2)-1]}"
			#	end
			#	puts "\n\n"
			end
		end

		def match_finished(match)
			
		end

		def graph(current_user)
			
		end
	end
end
