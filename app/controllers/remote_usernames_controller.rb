class RemoteUsernamesController < ApplicationController
	before_action :set_remote_username, only: [:show, :edit, :update, :destroy]

	# GET /remote_usernames
	# GET /remote_usernames.json
	def index
		@remote_usernames = RemoteUsername.all
	end

	# GET /remote_usernames/1
	# GET /remote_usernames/1.json
	def show
	end

	# GET /remote_usernames/new
	def new
		@remote_username = RemoteUsername.new
	end

	# GET /remote_usernames/1/edit
	def edit
	end

	# POST /remote_usernames
	# POST /remote_usernames.json
	def create
		@remote_username = RemoteUsername.new(remote_username_params)

		respond_to do |format|
			if @remote_username.save
				format.html { redirect_to @remote_username, notice: 'Remote username was successfully created.' }
				format.json { render action: 'show', status: :created, location: @remote_username }
			else
				format.html { render action: 'new' }
				format.json { render json: @remote_username.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /remote_usernames/1
	# PATCH/PUT /remote_usernames/1.json
	def update
		respond_to do |format|
			if @remote_username.update(remote_username_params)
				format.html { redirect_to @remote_username, notice: 'Remote username was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @remote_username.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /remote_usernames/1
	# DELETE /remote_usernames/1.json
	def destroy
		@remote_username.destroy
		respond_to do |format|
			format.html { redirect_to remote_usernames_url }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_remote_username
		@remote_username = RemoteUsername.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def remote_username_params
		params.require(:remote_username).permit(:game_id, :user_id, :user_name)
	end
end
