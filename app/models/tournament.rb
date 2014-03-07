class Tournament < ActiveRecord::Base
	belongs_to :game
	has_many :matches
	has_and_belongs_to_many :players, class_name: "User", join_table: "tournaments_players"
	has_and_belongs_to_many :hosts,   class_name: "User", join_table: "tournaments_hosts"

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
end
