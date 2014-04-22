require 'ScoringAlgorithm'

class MarginalPeer < ScoringAlgorithm

	def self.score(match, interface)
		match.players.each do |player|
			scores[player.user_name] = scoreUser(interface.getStatistic(match, player, rating))
		end
		scores
	end

	def self.score(rating)
		rating
	end
end