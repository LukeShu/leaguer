module Scoring
	module FibonacciPeerWithBlowout
		def self.stats_needed
			return [:votes]
		end

		def self.score(match)
			scores = {}
			match.players.each do |player|
				scores[player] = self.score_user(match.statistics.where(user: player, name: :votes).first, match.win?(player), match.blowout)
			end
			scores
		end

		protected

		def self.score_user(votes, win, blowout)
			fibonacci = Hash.new { |h,k| h[k] = k < 2 ? k : h[k-1] + h[k-2] }
			fibonacci[votes+3] + (win ? blowout ? 12 : 10 : blowout ? 5 : 7)
		end
	end
end
