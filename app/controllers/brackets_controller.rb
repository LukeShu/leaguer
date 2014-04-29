class BracketsController < ApplicationController
	before_action :set_tournament, only: [:index, :create]

	# GET /brackets
	# GET /brackets.json
	def index
		@tournament = Tournament.find(params[:tournament_id])
		@brackets = @tournament.brackets
	end

	# GET /brackets/1
	# GET /brackets/1.json
	def show
		@matches = @tournament.stages.first.matches_ordered
		@numTeams = @tournament.min_teams_per_match
		@logBase = @numTeams
			
		# depth of SVG tree
		@depth = Math.log(@matches.count*(@logBase-1),@logBase).floor+1;
			
		# height of SVG
		@matchHeight = 50*@logBase;
		@height = [(@matchHeight+50) * @logBase**(@depth-1) + 100, 500].max;

		@base = 1
		@pBase = 1
	end

	# GET /brackets/1/edit
	def edit
	end

	# POST /brackets
	# POST /brackets.json
	def create
		@bracket = @tournament.brackets.build(user: current_user)
		@bracket.name =  current_user.user_name + "'s Prediction for " + @tournament.name

		respond_to do |format|
			if @tournament.status == 1 && @tournament.stages.first.scheduling_method == "elimination" && @tournament.stages.first.matches.first.status < 2
				@bracket.save
				@bracket.create_matches
				format.html { redirect_to @bracket, notice: 'Bracket was successfully created.' }
				format.json { render action: 'edit', status: :created, location: @bracket }
			else
				format.html { redirect_to tournaments_path action: 'You can\'t make a bracket for this tournament' }
				format.json { render json: @bracket.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /brackets/1
	# PATCH/PUT /brackets/1.json
	def update
		respond_to do |format|
			if @bracket.update(bracket_params)
				format.html { redirect_to @tournament, notice: 'Bracket was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @bracket.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /brackets/1
	# DELETE /brackets/1.json
	def destroy
		@bracket.destroy
		respond_to do |format|
			format.html { redirect_to brackets_url }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_bracket
		@tournament = Tournament.find(params[:tournament_id])
		@bracket = Bracket.find(params[:id])
	end

	def set_tournament
		@tournament = Tournament.find(params[:tournament_id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def bracket_params
		params.require(:bracket).permit(:user_id, :tournament_id, :name)
	end

	def is_owner?(bracket)
		bracket.user == current_user
	end
end
