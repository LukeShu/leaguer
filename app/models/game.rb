class Game < ActiveRecord::Base
	belongs_to :parent, class_name: "Game"
	has_many :children, class_name: "Game"
	has_many :game_settings

	alias_attribute :settings, :game_settings
end
