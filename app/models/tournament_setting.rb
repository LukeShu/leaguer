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
