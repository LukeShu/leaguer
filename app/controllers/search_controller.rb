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
