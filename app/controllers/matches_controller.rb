class MatchesController < ApplicationController
	before_action :set_tournament, only: [:index, :new, :create]
	before_action :set_match, only: [:show, :edit, :update, :destroy]
	# GET /matches
	# GET /matches.json
	def index
		@matches = @tournament.matches
	end

	# GET /matches/1
	# GET /matches/1.json
	def show
	end

	# GET /matches/new
	def new

	end

	# GET /matches/1/edit
	def edit
	end

	# POST /matches
	# POST /matches.json
	def create
		@match = @tournament.matches.build(match_params)

		respond_to do |format|
			if @match.save
				format.html { redirect_to tournament_matches_path, notice: 'Match was successfully created.' }
				format.json { render action: 'show', status: :created, location: @match }
			else
				format.html { render action: 'new' }
				format.json { render json: @match.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /matches/1
	# PATCH/PUT /matches/1.json
	def update
		respond_to do |format|
			if @match.update(match_params)
				format.html { redirect_to [@tournament, @match], notice: 'Match was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @match.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /matches/1
	# DELETE /matches/1.json
	def destroy

		@match.destroy
		respond_to do |format|
			format.html { redirect_to tournament_matches_path }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_match
		@tournament = Tournament.find(params[:tournament_id])
		@match = @tournament.matches.find(params[:id]);
	end
	def set_tournament
		@tournament = Tournament.find(params[:tournament_id])
	end
	# Never trust parameters from the scary internet, only allow the white list through.
	def match_params
		params.require(:match).permit(:status, :tournament_id, :name, :winner_id, :remote_id)
	end
end
