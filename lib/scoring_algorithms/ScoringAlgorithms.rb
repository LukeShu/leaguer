class ScoringAlgorithm
	def self.score(*args)
	end
end

class FibonacciPeerWithBlowout < ScoringAlgorithm
	def self.score(votes, win, blowout)
		fibonacci = Hash.new{ |h,k| h[k] = k < 2 ? k : h[k-1] + h[k-2] }
		fibonacci[votes+3] + (win ? blowout ? 12 : 10 : blowout ? 5 : 7)
	end
end

class WinnerTakesAll < ScoringAlgorithm
	def self.score(win)
		win.nil? ? 0.5 : win ? 1 : 0
	end
end

class MarginalPeer < ScoringAlgorithm
	def self.score(rating)
		rating
	end
end


#puts Recommended.score(4, true, false)
#puts WinnerTakesAll.score(nil)
#puts WinnerTakesAll.score(true)
