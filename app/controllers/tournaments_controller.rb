class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy, :join]
  before_action :check_perms, only: [:new, :create, :edit, :destroy]

  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.all
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
    case @tournament.status
    when 0
    when 1..2
      redirect_to "/tournaments/" + @tournament.id.to_s + "/matches" #tournament_matches_page(@tournament)
    end
  end

  # GET /tournaments/new
  def new
    @games = Game.all
    @tournament = Tournament.new(game: Game.find_by_id(params[:game]))  
  end

  # GET /tournaments/1/edit
  def edit
    if params['close_action'] == 'close'
      @tournament.status = 1
      @tournament.save
      @tournament.setup(@tournament)
      redirect_to "/tournaments"
    end
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
  	
    if params[:update_action].nil?
      check_perms
      respond_to do |format|
        if @tournament.update(tournament_params)
          format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @tournament.errors, status: :unprocessable_entity }
        end
      end
    else
      case params[:update_action]
      when "join"
        respond_to do |format|
          if @tournament.join(current_user)
            format.html { render action: 'show', notice: 'You have joined this tournament.' }
            format.json { head :no_content }
          end
          format.html { render action: 'permission_denied', status: :forbidden }
          format.json { render json: "Permission denied", status: :forbidden }
        end
      when "open"
        respond_to do |format|
          if @tournament.setup
            format.html { render action: 'show', notice: 'You have joined this tournament.' }
            format.json { head :no_content }
          end
          format.html { render action: 'permission_denied', status: :forbidden }
          format.json { render json: "Permission denied", status: :forbidden }
        end
      #when "close"
        # TODO
      else
        respond_to do |format|
          format.html { render action: 'show', notice: "Invalid action", status: :unprocessable_entity }
          format.json { render json: @tournament.errors, status: :unprocessable_entity }
        end
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
      @tournament = Tournament.find(params[:id])
    end

	def check_perms
  		unless (signed_in? and current_user.in_group?(:host))
  			respond_to do |format|
  				format.html { render action: 'permission_denied', status: :forbidden }
  				format.json { render json: "Permission denied", status: :forbidden }
  			end
  		end
  	end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_params
      params.require(:tournament).permit(:game, :name, :game_id, :status, :min_players_per_team, :max_players_per_team, :min_teams_per_match, :max_teams_per_match, :set_rounds, :randomized_teams)
    end
end
