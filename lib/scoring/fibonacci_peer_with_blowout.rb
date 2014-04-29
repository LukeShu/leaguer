module Scoring
	module FibonacciPeerWithBlowout
		def self.stats_needed
			return [:votes, :win, :blowout]
		end

		def self.score(match)
			scores = {}
			match.players.each do |player|
				stats = Statistics.where(user: player, match: match)

				votes   = stats.where(name: :votes  ).first
				win     = stats.where(name: :win    ).first
				blowout = stats.where(name: :blowout).first

				scores[player] = self.score_user(votes, win, blowout)
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
