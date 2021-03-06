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

class TournamentsController < ApplicationController

	# GET /tournaments
	# GET /tournaments.json
	def index
		@tournaments = Tournament.all
	end

	# GET /tournaments/1
	# GET /tournaments/1.json
	def show
		respond_to do |format|
			format.html {  
				case @tournament.status
				when 0
					render action: 'show'
				when 1
					redirect_to tournament_matches_path(@tournament)
				when 2
					redirect_to tournaments_page
				end
			}
			format.json { 
				data = JSON.parse(@tournament.to_json)
				data["players"] = @tournament.players;
				render :json => data.to_json
			}
		end
	end

	# GET /tournaments/new
	def new
		@tournament = Tournament.new(tournament_attribute_params)
		if @tournament.game
			@tournament.game.settings.each do |game_setting|
				@tournament.tournament_settings.build(
					name:          game_setting.name,
					value:         game_setting.value,
					vartype:       game_setting.vartype,
					type_opt:      game_setting.type_opt,
					description:   game_setting.description,
					display_order: game_setting.display_order)
			end
		end
	end

	# GET /tournaments/1/edit
	def edit
		check_permission(:edit, @tournament)
	end

	# POST /tournaments
	# POST /tournaments.json
	def create
		ok = true
		begin
			ActiveRecord::Base.transaction do
				ok &= @tournament = Tournament.new(tournament_attribute_params.merge({hosts: [current_user]}))
				ok &= @tournament.update(tournament_setting_params)
				for i in 1..(params[:num_stages].to_i) do
					begin
						ok &= @tournament.stages.build(tournament_stage_params(i))
					rescue ActionController::ParameterMissing => e
						ok = false
						@tournament.errors.add("stages[#{i}]", "needs to be set")
					end
				end
				ok &= @tournament.save
			end
		rescue ActiveRecord::RecordNotUnique => e
			ok = false
			@tournament.errors.add(:name, "must be unique")
		rescue => e
			ok = false
			@tournament.errors.add(:exception, "Unknown error: ``#{e.class.name}'' -- #{e.inspect} -- #{e.methods - Object.new.methods}")
		end
		respond_to do |format|
			if ok
				format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
				format.json { render action: 'show', status: :created, location: @tournament }
			else
				format.html { render action: 'new' }
				format.json { render json: @tournament.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /tournaments/1
	# PATCH/PUT /tournaments/1.json
	def update
		case params[:update_action]
		when nil
			check_permission(:edit, @tournament)
			ok = true
			ActiveRecord::Base.transaction do
				ok &= @tournament.update(tournament_attribute_params)
				ok &= @tournament.update(tournament_setting_params)
			end
			respond_to do |format|
				if ok
					format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
					format.json { head :no_content }
				else
					format.html { render action: 'edit' }
					format.json { render json: @tournament.errors, status: :unprocessable_entity }
				end
			end
		when "join"
			# permission checking for join is done in the Tournament model
			respond_to do |format|
				if @tournament.join(current_user)
					format.html { redirect_to @tournament, notice: 'You have joined this tournament.' }
					format.json { head :no_content }
				else
					format.html { redirect_to @tournament, notice: "You can't join this tournament." }
					format.json { render json: "Permission denied", status: :forbidden }
				end
			end
		when "leave"
			respond_to do |format|
				if @tournament.leave(current_user)
					format.html { redirect_to tournaments_url, notice: 'You have left the tournament.' }
					format.json { head :no_content }
				else
					format.html { redirect_to @tournament, notice: 'You were\'t a part of this tournament.' }
					format.json { render json: "Permission denied", status: :forbidden }
				end
			end
		when "start"
			check_permission(:edit, @tournament)
			respond_to do |format|
				if @tournament.status == 0
					@tournament.status = 1
					@tournament.save
					success = true
					ActiveRecord::Base.transaction do
					#	sched = tournament_attribute_params[:type_opt]
					#	success &= @tournament.stages.create(scheduling_method: sched)
						success &= @tournament.stages.first.create_matches
					end
					if success
						format.html { redirect_to @tournament, notice: 'You have started this tournament.' }
						format.json { head :no_content }
					else
						format.html { redirect_to @tournament, notice: "You don't have permission to start this tournament." }
						format.json { render json: "Permission denied", status: :forbidden }
					end
				else
					format.html { redirect_to @tournament, notice: "This tournament is not in a state that it can be started." }
					format.json { render json: "Permission denied", status: :forbidden }
				end
			end
		else
			respond_to do |format|
				format.html { redirect_to @tournament, notice: "Invalid action", status: :unprocessable_entity }
				format.json { render json: @tournament.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /tournaments/1
	# DELETE /tournaments/1.json
	def destroy
		@tournament.destroy
		respond_to do |format|
			format.html { redirect_to tournaments_url }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_tournament
		begin
			@tournament = Tournament.find(params[:id])
		rescue
			redirect_to tournaments_url, notice: 'That tournament no longer exists.'
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def tournament_attribute_params
		params[:num_stages] ||= 1
		if params[:tournament]
			p = params.require(:tournament).permit(:game_id, :status, :name, :min_players_per_team, :max_players_per_team, :min_teams_per_match, :max_teams_per_match, :scoring_method)
			if p[:game_id]
				game = Game.find(p[:game_id])
				p[:min_players_per_team] ||= game.min_players_per_team
				p[:max_players_per_team] ||= game.max_players_per_team
				p[:min_teams_per_match]  ||= game.min_teams_per_match
				p[:max_teams_per_match]  ||= game.max_teams_per_match
				p[:scoring_method]       ||= game.scoring_method
			end
			return p
		else
			return {}
		end
	end

	def tournament_setting_params
		if tournament_attribute_params[:game_id]
			game = Game.find(params[:tournament][:game_id])
			params.require(:tournament).permit({:settings => game.settings.collect{|s| s.name}})
		else
			return {}
		end
	end

	def tournament_stage_params(i)
		params.require(:tournament).require(:stages).require(i.to_s).permit(:scheduling_method, :seeding_method)
	end

	# Turn of check_edit, since our #update is flexible
	def check_edit
		set_tournament
	end

end
