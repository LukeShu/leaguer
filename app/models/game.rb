class Game < ActiveRecord::Base
	has_many :settings, class_name: "GameSetting" 
end
