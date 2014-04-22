class Match < ActiveRecord::Base
	belongs_to :tournament_stage
	belongs_to :winner
end
