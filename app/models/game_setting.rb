class GameSetting < ActiveRecord::Base
	belongs_to :game
	belongs_to :parent
end
