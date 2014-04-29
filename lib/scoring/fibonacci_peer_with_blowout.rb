module Scoring
	module FibonacciPeerWithBlowout
		def self.stats_needed
			return ["votes", "win", "blowout"]
		end

		def self.score(match)
			scores = {}
			match.users.each do |user|
				stats = Statistic.where(user: user, match: match)

				votes   = stats.where(name: "votes"  ).first.value
				win     = stats.where(name: "win"    ).first.value
				blowout = stats.where(name: "blowout").first.value
				scores[user] = self.score_user(votes, win, blowout)
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
