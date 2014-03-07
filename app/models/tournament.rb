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
end
