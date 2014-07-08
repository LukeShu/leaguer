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

class MatchesController < ApplicationController
	require 'httparty'
	require 'json'
	require 'delayed_job'

	before_action :set_tournament, only: [:index]

	# GET /tournaments/1/matches
	# GET /tournaments/1/matches.json
	def index
	end

	# GET /tournaments/1/matches/1
	# GET /tournaments/1/matches/1.json
	def show
	end

	# PATCH/PUT /tournaments/1/matches/1
	# PATCH/PUT /tournaments/1/matches/1.json
	def update
		notice = nil
		case @match.status
		when 0
			# Created, waiting to be scheduled
		when 1
			# Scheduled, waiting to start
			if (@tournament.hosts.include? current_user) and (params[:update_action] == "start")
				@match.status = 2
				@match.start_sampling
				if @match.save
					notice = 'Match has started.'
				else
					respond_to do |format|
						format.html { render action: 'show' }
						format.json { render json: @match.errors, status: :unprocessable_entity }
					end
					return
				end
			end
		when 2
			# Started, waiting to finish
			@match.handle_sampling(current_user, params)
			# The @match.status will be updated by Statistic's after_save hook
			if @match.status == 3
				notice = 'Match has finished'
			end
		when 3
			if (@tournament.hosts.include? current_user) and (params[:update_action] == "start")
				ok = true
				ActiveRecord::Base.transaction do
					ok &= @match.statistics.destroy_all
					ok &- @match.status = 1
					ok &= @match.save
				end
				if ok
					notice = "Match has been reset"
				else
					respond_to do |format|
						format.html { render action: 'show' }
						format.json { render json: @match.errors, status: :unprocessable_entity }
					end
					return
				end
			end
		end
		respond_to do |format|
			format.html { redirect_to match_path(@match), notice: notice }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_match
		@match = Match.find(params[:id])
		@tournament = @match.tournament_stage.tournament
	end

	def set_tournament
		@tournament = Tournament.find(params[:tournament_id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def match_params
		params.require(:match).permit(:status, :tournament_stage_id, :winner_id)
		params.require(:match).permit(:status, :tournament_stage_id, :winner_id)
	end

	# Turn of check_edit, since our #update is flexible
	def check_edit
		set_match
	end
end
