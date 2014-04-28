module Scheduling
	class RoundRobin
		include Rails.application.routes.url_helpers

		def initialize(tournament_stage)
			@tournament_stage = tournament_stage
		end

		def create_matches
			# => find the number of matches and teams to create
			@num_teams = (tournament.players.count/tournament.min_players_per_team).floor
			@matches_per_round = @num_teams * tournament.min_teams_per_match

			# => initialize data and status members
			@team_pairs ||= Array.new
			if @team_pairs.empty?
				@matches_finished = 0
			end

			# => Create new matches
			@matches_per_round.times do
				tournament_stage.matches.create(status: 0, submitted_peer_evaluations: 0)
			end

			# => seed the first time
			if @team_pairs.empty?
				tournament_stage.seeding.seed(tournament_stage)
				tournament_stage.matches.each {|match| match.teams.each {|team| @team_pairs.push team}}
			else
				# => Reorder the list of teams
				top = @team_pairs.shift
				@team_pairs.push @team_pairs.shift
				@team_pairs.unshift top

				# => Add the teams to the matches
				match = tournament_stage.matches[@matches_finished-1]
				matches = 1
				(0..@team_pairs.count-1).each do |i|
					match.teams += @team_pairs[i]
					if @team_pairs.count.%(tournament.min_teams_per_match).zero?
						match = tournament_stage.matches[@matches_finished-1 + matches]
						matches += 1
					end
				end

			end
		end

		def finish_match(match)
			@matches_finished += 1
		end

		def graph(current_user)
		end

		private
		def tournament_stage
			@tournament_stage
		end

		def tournament
			tournament_stage.tournament
		end
	end
end
