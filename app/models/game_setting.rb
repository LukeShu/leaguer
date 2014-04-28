class GameSetting < ActiveRecord::Base
	belongs_to :game

	alias_attribute :value, :default

	def self.types
		return {
			:text_short => 0,
			:text_long => 1,
			:pick_one_radio => 2,
			:pick_several => 3,
			:true_false => 4,
			:pick_one_dropdown => 5,
		}
	end
end
