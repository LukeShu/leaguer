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
					#redirect_to tournament_matches_page(@tournament)
					redirect_to "/tournaments/" + @tournament.id.to_s + "/matches"
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
		@games = Game.all
		if params[:tournament]
			@tournament = Tournament.new(game: Game.find(params[:tournament][:game_id]))
		else
			@tournament = Tournament.new()
		end
	end

	# GET /tournaments/1/edit
	def edit
		check_permission(:edit, @tournament)
	end

	# POST /tournaments
	# POST /tournaments.json
	def create
		@tournament = Tournament.new(tournament_params)
		@tournament.status = 0
		respond_to do |format|
			if @tournament.save
				@tournament.hosts.push(current_user)
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
			respond_to do |format|
				if @tournament.update(tournament_params)
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
					success = true
					ActiveRecord::Base.transaction do
						success &= @tournament.save &&
						success &= @tournament.tournament_stages.create(scheduling: "elimination")
						success &= @tournament.tournament_stages.first.create_matches
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
	def tournament_params
		permitted = [:game_id, :status, :name, :min_players_per_team, :max_players_per_team, :min_teams_per_match, :max_teams_per_match, :set_rounds, :randomized_teams, :sampling_method]
		if params[:tournament][:game_id]
			game = Game.find(params[:tournament][:game_id])
			permitted.push(:settings => game.settings.collect{|s| s.name})
		end
		params.require(:tournament).permit(permitted)
	end

	def is_owner?(object)
		object.hosts.include?(current_user)
	end

	# Turn of check_edit, since our #update is flexible
	def check_edit
		set_tournament
	end

end
