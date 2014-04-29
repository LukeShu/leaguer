class Game < ActiveRecord::Base
	belongs_to :parent, class_name: "Game"

	has_many :children, class_name: "Game"

	has_many :game_settings
	validates_associated :game_settings
	alias_attribute :settings, :game_settings

	validates(:name,
		presence: true,
		length: {minimum: 5},
		uniqueness: {case_sensitive: true})

	validates(:min_players_per_team,
		presence: true,
		numericality: {
			only_integer: true,
			less_than_or_equal_to: :max_players_per_team,
		})
	validates(:max_players_per_team,
		presence: true,
		numericality: {
			only_integer: true,
			greater_than_or_equal_to: :min_players_per_team,
		})

	validates(:min_teams_per_match,
		presence: true,
		numericality: {
			only_integer: true,
			less_than_or_equal_to: :max_teams_per_match,
		})
	validates(:max_teams_per_match,
		presence: true,
		numericality: {
			only_integer: true,
			greater_than_or_equal_to: :min_teams_per_match,
		})

	validate :validate_scoring_method
	def validate_scoring_method
		(not self.scoring_method.try(:empty?)) and (Tournament.scoring_methods.include? scoring_method)
	end
end
