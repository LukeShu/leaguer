module Scoring
	module FibonacciPeerWithBlowout
		def self.stats_needed(match)
			return ["votes", "win", "blowout"] + match.users.map{|u|"review_from_#{u.user_name}"}
		end

		def self.score(match)
			scores = {}
			match.users.each do |user|
				stats = user.statistics.where(match: match)
				votes = 0
				match.users.each do |u|
					votes += convert_place_to_votes stats.where(name: "review_from_#{u.user_name}").first.value
				end
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

		def self.convert_place_to_votes(place)
			(place == 0 or place == 1) ? 1 : 0
		end
	end
end
