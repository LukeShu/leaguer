class BracketMatch < ActiveRecord::Base
	belongs_to :bracket
	belongs_to :match
	belongs_to :predicted_winner
end
