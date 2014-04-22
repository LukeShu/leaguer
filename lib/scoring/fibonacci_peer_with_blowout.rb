require 'ScoringAlgorithm'

class FibonacciPeerWithBlowout < ScoringAlgorithm

	def self.score(match, interface)
		match.players.each do |player|
			scores[player.user_name] = scoreUser(interface.getStatistic(match, player, :votes), match.win?(player), match.blowout)
		end
		scores
	end

	def self.scoreUser(votes, win, blowout)
		fibonacci = Hash.new { |h,k| h[k] = k < 2 ? k : h[k-1] + h[k-2] }
		fibonacci[votes+3] + (win ? blowout ? 12 : 10 : blowout ? 5 : 7)
	end
end