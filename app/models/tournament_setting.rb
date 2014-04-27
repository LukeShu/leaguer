class TournamentSetting < ActiveRecord::Base
	belongs_to :tournament

	def self.types
		GameSetting.types
	end
end
