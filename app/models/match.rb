class Match < ActiveRecord::Base
	belongs_to :tournament
	has_many :scores
	has_and_belongs_to_many :teams

	belongs_to :winner, class_name: "Team"

	def setup()
		
	end
end
