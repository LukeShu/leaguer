class Bracket < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament
	has_many :bracket_matches

	def create_matches
		tournament.stages.first.matches_ordered.each do |m|
			bracket_matches.create(match: m)
		end
	end
end
