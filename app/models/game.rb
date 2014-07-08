# Copyright (C) 2014 Andrew Murrell
# Copyright (C) 2014 Davis Webb
# Copyright (C) 2014 Guntas Grewal
# Copyright (C) 2014 Luke Shumaker
# Copyright (C) 2014 Nathaniel Foy
# Copyright (C) 2014 Tomer Kimia
#
# This file is part of Leaguer.
#
# Leaguer is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Leaguer is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the Affero GNU General Public License
# along with Leaguer.  If not, see <http://www.gnu.org/licenses/>.

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
