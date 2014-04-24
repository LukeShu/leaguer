class Game < ActiveRecord::Base
	belongs_to :parent, class_name: "Game"
	has_many :children, class_name: "Game"
	has_many :settings, class_name: "GameSetting"
end
