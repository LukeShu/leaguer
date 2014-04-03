class Tournament < ActiveRecord::Base
	belongs_to :game
	has_many :matches
	has_and_belongs_to_many :players, class_name: "User", association_foreign_key: "player_id", join_table: "players_tournaments"
	has_and_belongs_to_many :hosts,   class_name: "User", association_foreign_key: "host_id",   join_table: "hosts_tournaments"

	def open?
		return true
	end

	def joinable_by?(user)
		return ((not user.nil?) and user.in_group?(:player) and open?)
	end

	def join(user)
		unless joinable_by?(user)
			return false
		end
		players.push(user)
	end

	def leave(user)
		if players.include?(user)
			players.delete(user)
		end
	end

	def setup(tournament)
		num_teams = (self.players.count/self.max_players_per_team).floor
		num_matches = num_teams - 1
		for i in 1..num_matches
			self.matches.create(name: "Match #{i}")
		end
		match_num = 0
		team_num = 0
		self.players.each_slice(tournament.max_players_per_team) do |players|
			self.matches[match_num].teams.push(Team.create(users: players))
			if (team_num != 0 and team_num % tournament.max_teams_per_match == 0)
				match_num += 1
				team_num = 0
			else
				team_num += 1
			end
		end
	end
end
