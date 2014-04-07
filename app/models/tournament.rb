class Tournament < ActiveRecord::Base
	belongs_to :game
	has_many :matches
	has_and_belongs_to_many :players, class_name: "User", association_foreign_key: "player_id", join_table: "players_tournaments"
	has_and_belongs_to_many :hosts,   class_name: "User", association_foreign_key: "host_id",   join_table: "hosts_tournaments"

	def open?
		return true
	end

	def joinable_by?(user)
		return (open? and user.can?(:join_tournament) and !players.include?(user))
	end

	def join(user)
		unless joinable_by?(user)
			return false
		end
		players.push(user)
	end

	def leave(user)
		if players.include?(user) && status == 0
			players.delete(user)
		end
	end

	def setup
		num_teams = (self.players.count/self.min_players_per_team).floor
		num_matches = num_teams - 1
		for i in 1..num_matches
			self.matches.create(name: "Match #{i}", status: 0)
		end
		match_num = num_matches-1
		team_num = 0
		#for each grouping of min_players_per_team
		players.each_slice(min_players_per_team) do |players|

			#if the match is full, move to the next match, otherwise move to the next team
			if (team_num == min_teams_per_match)
				match_num -= 1
				team_num = 0
			else
				team_num += 1
			end
			#create a new team in the current match
			self.matches[match_num].teams.push(Team.create(users: players))
		end
	end
end
