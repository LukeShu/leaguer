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

class Bracket < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament
	has_many :bracket_matches

	def owned_by?(tuser)
		self.user == tuser
	end

	def create_matches
		tournament.stages.order(:id).first.matches.order(:id).each do |m|
			bracket_matches.create(match: m)
		end
	end


	def predict_winners(predictions)
		(0..bracket_matches.count-1).each do |i|
			bracket_matches.order(:match_id)[i].update(predicted_winner: Team.find(predictions[(i+1).to_s]));
		end 
		return true
	end


	def calcResults
		results = Array.new
		(0..bracket_matches.count-1).each do |i|
				results.push(bracket_matches.order(:match_id)[i].predicted_winner == tournament.stages.order(:id).first.matches.order(:id).winner)
		end 
		return results
	end
end
