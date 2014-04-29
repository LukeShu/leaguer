module Scoring
	module WinnerTakesAll
		def self.stats_needed(match)
			return ["win"]
		end

		def self.score(match)
			scores = {}
			match.users.each do |user|
				stats = Statistic.where(user: user, match: match)
				scores[user] = score_user(stats.where(name: "win").first)
			end
			scores
		end

		private
		def self.score_user(win)
			win.nil? ? 0.5 : win ? 1 : 0
		end
	end
end
