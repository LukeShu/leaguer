class TournamentSetting < ActiveRecord::Base
	belongs_to :tournament

	validates(:vartype, presence: true, numericality: {only_integer: true})
	validates(:type_opt, presence: true, if: :needs_type_opt?)

	def owned_by?(user)
		self.tournament.owned_by?(user)
	end

	def needs_type_opt?
		[
			GameSetting.types[:pick_one_radio],
			GameSetting.types[:pick_one_dropdown],
			GameSetting.types[:pick_several],
		].include? self.vartype
	end


	def self.types
		GameSetting.types
	end
end
