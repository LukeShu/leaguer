module Scoring
	module WinnerTakesAll
		def self.stats_needed(match)
			return ["win"]
		end

		def self.score(match)
			scores = {}
			match.users.each do |user|
				stats = Statistic.where(user: user, match: match)
				scores[user] = stats.where(name: "win").first.value ? 1 : 0
			end
			scores
		end
	end
end
