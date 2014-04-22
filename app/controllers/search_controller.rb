class SearchController < ApplicationController

	def go
		@query = params[:query]

		if (@query.nil?) return;

		@tournaments = Tournament.where("name LIKE '#{@query}'")
		@players = User.where("name LIKE '#{@query}")

	end

end
