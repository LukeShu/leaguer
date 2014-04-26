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

		def create_round_array
			#round robin should look like this.
			#NOTE: I DO NOT KNOW IF THIS IS HOW TO PROPERLY POPULATE THE ROUND ROBIN ARRAY WITH TEAMS
			@team_pairs = Array.new(num_matches)
			for i in 0..@match.teams.size
				@team_pairs.push(@match.teams[i])
				#if there is an odd number of teams, add a dummy for byes
				if @match.teams.size % 2 != 0 && i == @match.teams.size-1
					dummy = Team.create
					@team_pairs.push(dummy)
				end
			end
		end

		#this is called when a round has completed
		def rotate
			#remove first team
			hold = @team_pairs.shift
			#rotate by 1 element
			@team_pairs.rotate!
			#place first team the front of the array
			@team_pairs.unshift(hold)
			
		end

		def mother_fuckin_winner
			scores = {}
			@teams_pairs.each do |team|
				scores[team] = team.matches.
					where(:tournament_stage => tournament_stage).
					collect{|match|match.winner==team}
			end
			weiner = scores.index(scores.max)
			scores[weiner]
		end

		def match_finished(match)
			#declare winner of match, and store that somehow
			rotate
			return "totes worked\n"
		end

		def graph(current_user)
			
		end
	end
end
