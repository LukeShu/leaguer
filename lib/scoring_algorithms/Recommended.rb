class Recommended #< ScoringAlgorithm	
	def self.score(votes, win, blowout)
		fibonacci = Hash.new{ |h,k| h[k] = k < 2 ? k : h[k-1] + h[k-2] }
		fibonacci[votes+3] + (win ? blowout ? 12 : 10 : blowout ? 5 : 7)
	end
end

#puts Recommended.score(4, true, false)
