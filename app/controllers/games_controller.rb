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

class GamesController < ApplicationController
	# GET /games
	# GET /games.json
	def index
		@games = Game.all
	end

	# GET /games/1
	# GET /games/1.json
	def show
	end

	# GET /games/new
	def new
		@game = Game.new
	end

	# GET /games/1/edit
	def edit
	end

	# POST /games
	# POST /games.json
	def create
		@game = Game.new(game_params)

		respond_to do |format|
			if @game.save
				format.html { redirect_to @game, notice: 'Game was successfully created.' }
				format.json { render action: 'show', status: :created, location: @game }
			else
				format.html { render action: 'new' }
				format.json { render json: @game.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /games/1
	# PATCH/PUT /games/1.json
	def update
		respond_to do |format|
			if @game.update(game_params)
				format.html { redirect_to @game, notice: 'Game was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @game.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /games/1
	# DELETE /games/1.json
	def destroy
		@game.destroy
		respond_to do |format|
			format.html { redirect_to games_url }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_game
		@game = Game.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def game_params
		params.require(:game).permit(:parent_id, :name, :min_players_per_team, :max_players_per_team, :min_teams_per_match, :max_teams_per_match, :scoring_method)
	end
end
