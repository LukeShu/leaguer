class SearchController < ApplicationController

	def go
		stringMade = false;
		@games = Game.all
		@query = params[:query]
		@gametype = params[:game_type]

		if ( @gametype.nil? and (@query.nil? or @query.empty?)) then 
			return 
		end

		qstring = ""
		if (!@query.empty?)
			qstring += "name LIKE '%#{@query}%'"
			stringMade = true
		end
		if (!@gametype.nil? and !@gametype.empty?)
			if (stringMade)
				qstring += " AND "
			end
			qstring += "game_id=#{@gametype}"
		end

		@tournaments = Tournament.where(qstring)
		@players = User.where("name LIKE '%#{@query}%'")

	end

end
