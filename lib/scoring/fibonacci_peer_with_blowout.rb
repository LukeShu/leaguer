module Scoring
	module FibonacciPeerWithBlowout
		def stats_needed
			return [:votes]
		end

		def score(match, interface)
			scores = {}
			match.players.each do |player|
				scores[player.user_name] = score_user(interface.get_statistic(match, player, :votes), match.win?(player), match.blowout)
			end
			scores
		end

		private
		def score_user(votes, win, blowout)
			fibonacci = Hash.new { |h,k| h[k] = k < 2 ? k : h[k-1] + h[k-2] }
			fibonacci[votes+3] + (win ? blowout ? 12 : 10 : blowout ? 5 : 7)
		end
	end
end
