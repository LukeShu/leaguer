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
		if @match.tournament_stage.tournament.game_id == 1
			file_blue = "blue.yaml"
			file_purple = "purple.yaml"
			@blue2 = YAML.load_file(file_blue)
			@purp2 = YAML.load_file(file_purple)
		end
	end

	# PATCH/PUT /tournaments/1/matches/1
	# PATCH/PUT /tournaments/1/matches/1.json
	def update
		case params[:update_action]
		when "start"
			#
			# Redirect to the current match page for this tournament with the correct sampling view rendered
			#

			@match.status = 1
			respond_to do |format|
				if @match.save
					format.html { redirect_to tournament_match_path(@tournament, @match), notice: 'Match has started.' }
					format.json { head :no_content }
				else
					format.html { redirect_to @tournament, notice: "You don't have permission to start this match." }
					format.json { render json: "Permission denied", status: :forbidden }
				end
			end
		when "finish"
			#
			# Get the winner and blowout status from the params given by the correct sampling view
			#

			unless @match.tournament_stage.tournament.sampling.sampling_done?
				@match.tournament_stage.tournament.sampling.handle_user_interaction(@match, current_user, params)
			end

			# Skip peer evaluation if there aren't enough players per team
			peer = false
			@match.teams.each do |team|
				if team.users.count > 2
					peer = true
				end
			end
			@match.status = peer ? 2 : 3

			respond_to do |format|
				if @match.save
					format.html { redirect_to tournament_match_path(@tournament, @match), notice: 'Peer evaluation started.' }
					format.json { head :no_content }
				else
					format.html { redirect_to @tournament, notice: "Permission denied" }
					format.json { render json: "Permission denied", status: :forbidden }
				end
			end		
		when "peer"
			#
			# Update user scores via scoring method
			#

			#update this to use scoring interface

			order = params[:review_action]
			base_score = 2
			next_score = 3
			order.split(",").reverse.each do |elem|
				player_score = base_score
				if @match.winner.user.include?(@current_user)
					player_score += 10
				else
					player_score += 7
				end
				Score.create(user: elem, match: @match, value: player_score )
				base_score = next_score
				next_score += base_score  
			end

			@match.submitted_peer_evaluations += 1
			players = []; @match.teams.each{|t| players.concat(t.users.all)}
			if (@match.submitted_peer_evaluations == players.count) 
				@match.status = 3
			end


			respond_to do |format|
				if @match.save
					format.html { redirect_to tournament_match_path(@tournament, @match), notice: 'Scores Submitted' }
					format.json { head :no_content }
				else
					format.html { redirect_to @tournament, notice: "You don't have permission to start this match." }
					format.json { render json: "Permission denied", status: :forbidden }
				end
			end
		when "reset"
			#
			# Reset Match Status to 1 in case something needs to be replayed.
			#

			@match.status = 1
			respond_to do |format|
				if @match.save
					format.html { redirect_to tournament_match_path(@tournament, @match), notice: 'Match Status Reset to 1' }
					format.json { head :no_content }
				else
					format.html { redirect_to @tournament, notice: "You don't have permission to start this match." }
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
		params.require(:match).permit(:status, :tournament_stage_id, :winner_id, :remote_id, :submitted_peer_evaluations, :update_action)
	end

	# Turn of check_edit, since our #update is flexible
	def check_edit
		set_match
	end
end
