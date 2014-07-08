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

class Statistic < ActiveRecord::Base
	belongs_to :user
	belongs_to :match

	validates(:name, presence: true, length: { minimum: 1 })

	def value
		begin
			return JSON::restore(self.json_value)
		rescue
			return {}
		end
	end

	def value=(v)
		self.json_value = v.to_json
	end

	after_save :update_match
	def update_match
		ActiveRecord::Base.transaction do
			if (self.name == "win") and (self.value)
				self.match.winner = self.match.teams.find{|t| t.users.include? self.user}
			end
			if 	(self.match.status == 2) and (self.match.finished?)
				self.match.status = 3
				self.match.tournament_stage.scheduling.finish_match(self.match)
			end
			self.match.save!
		end
	end
end
