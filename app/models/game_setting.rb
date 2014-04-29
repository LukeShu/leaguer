class GameSetting < ActiveRecord::Base
	belongs_to :game

	alias_attribute :value, :default

	validates(:vartype, presence: true, numericality: {only_integer: true})
	validates(:type_opt, presence: true, if: :needs_type_opt?)

	def needs_type_opt?
		[
			GameSetting.types[:pick_one_radio],
			GameSetting.types[:pick_one_dropdown],
			GameSetting.types[:pick_several],
		].include? self.vartype
	end

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
