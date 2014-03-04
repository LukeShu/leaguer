class SessionsController < ApplicationController

	# GET /sessions/new
	def new
		if @user.nil?
			@user = User.new
		end
	end
	
	# POST /sessions
	def create
		# find the user...
		@user = User.find_by(email: params[:session][:email].downcase)
		# ... and create a new session
		if @user && @user.authenticate(params[:session][:password])
			sign_in @user
			redirect_to root_path
		else
			redirect_to new_session_path
		end
	end

	# DELETE /sessions/current
	def destroy
		sign_out
		redirect_to root_path
	end
end
