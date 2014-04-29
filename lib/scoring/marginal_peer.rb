module Scoring
	module MarginalPeer
		def self.stats_needed
			return ["rating", "win"]
		end

		def self.score(match)
			scores = {}
			match.users.each do |user|
				stats = Statistic.where(user: user, match: match)
				scores[user] = stats.where(name: "rating").first.value
			end
			scores
		end
	end
end
