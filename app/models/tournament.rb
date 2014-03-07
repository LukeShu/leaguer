class Tournament < ActiveRecord::Base
	belongs_to :game
	has_many :matches
	has_many :user_tournament_pairs
	has_many :users, :through => :user_tournament_pairs

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
		pair = UserTournamentPair.new(tournament: self, user: user)
		return pair.save
	end

	def setup
		num_teams = (self.users.count/self.players_per_team).floor
		num_matches = num_teams - 1
		for i in 0..num_matches
			self.matches.create(name: "Match #{i}")
		end
		#self.players.each_slice(num_teams) do |team_players|
		#	Team.new(users: team_players)
		#end
	end


end
