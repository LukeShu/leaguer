module Scoring
	module MarginalPeer
		def stats_needed
			return [:rating]
		end

		def score(match, interface)
			scores = {}
			match.players.each do |player|
				scores[player.user_name] = interface.get_statistic(match, player, :rating)
			end
			scores
		end
	end
end
