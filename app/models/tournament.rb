class Tournament < ActiveRecord::Base
	belongs_to :game
	has_many :matches
	has_many :users, :through => :user_tournament_pair

	def open?
		return true
	end

	def joinable_by?(user)
		return ((not user.nil?) and user.in_group?(:player) and open?)
	end

	def join(user)
		unless joinable?(user)
			return false
		end
		pair = new_user_tournament_pair(user: user)
		return pair.save
	end
end
