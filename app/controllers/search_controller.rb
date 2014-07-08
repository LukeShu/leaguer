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

class SearchController < ApplicationController

	def go
		@games = Game.all
		@query = params[:query]
		@gametype = params[:game_type]

		if ( @gametype.nil? and (@query.nil? or @query.empty?)) then 
			return 
		end

		tour_filters = []
		user_filters = []
		unless @query.empty?
			tour_filters.push(["name LIKE ?", "%#{@query}%"])
			user_filters.push(["name LIKE ?", "%#{@query}%"])
		end
		unless @gametype.nil? or @gametype.empty?
			tour_filters.push(["game_id = ?", @gametype])
		end

		if tour_filters.empty?
			@tournamets = []
		else
			@tournaments = Tournament
			tour_filters.each do |filter|
				@tournaments = @tournaments.where(*filter)
			end
		end

		if user_filters.empty?
			@players = []
		else
			@players = User
			user_filters.each do |filter|
				@players = @players.where(*filter)
			end
		end
	end

end
