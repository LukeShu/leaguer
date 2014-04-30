class BracketMatch < ActiveRecord::Base
	belongs_to :bracket
	belongs_to :match
	belongs_to :predicted_winner, class_name: "Team"

	def owned_by?(user)
		self.bracket.owned_by?(user)
	end
end
