class Bracket < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament
	has_many :bracket_matches

	def create_matches
		tournament.stages.order(:id).first.matches.order(:id).each do |m|
			bracket_matches.create(match: m)
		end
	end


	def predict_winners(predictions)
		require 'pp'
		puts("<"*80)
		pp predictions
		puts(">"*80)
		(0..bracket_matches.count-1).each do |i|
			bracket_matches.order(:match_id)[i].update(predicted_winner: Team.find(predictions[(i+1).to_s]));
		end 
		return true
	end


	def calcResults
		results = Array.new
		(0..bracket_matches.count-1).each do |i|
				results.push(bracket_matches.order(:match_id)[i].predicted_winner == tournament.stages.order(:id).first.matches.order(:id).winner)
		end 
		return results
	end
end
