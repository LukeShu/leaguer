require 'ScoringAlgorithm'

class WinnerTakesAll < ScoringAlgorithm

	def self.score(match, interface)
		match.players.each do |player|
			scores[player.user_name] = scoreUser(match.win?(player))
		end
		scores
	end


	def self.score(win)
		win.nil? ? 0.5 : win ? 1 : 0
	end
end