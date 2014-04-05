class MatchesController < ApplicationController
	before_action :set_tournament, only: [:index]

	# GET /matches
	# GET /matches.json
	def index
		@matches = @tournament.matches
	end

	# GET /matches/1
	# GET /matches/1.json
	def show
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_match
		set_tournament
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
