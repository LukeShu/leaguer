module Scoring
	module WinnerTakesAll
		def self.stats_needed
			return []
		end

		def self.score(match, interface)
			scores = {}
			match.players.each do |player|
				scores[player.user_name] = score_user(match.win?(player))
			end
			scores
		end

		private
		def self.score_user(win)
			win.nil? ? 0.5 : win ? 1 : 0
		end
	end
end
