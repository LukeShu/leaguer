class SessionsController < ApplicationController

	# GET /sessions/new
	def new
		@user = User.new
	end
	
	# POST /sessions
	def create
		# find the user...
		@user = User.find_by(email: params[:session][:email].downcase)
		# ... and create a new session
		respond_to do |format|
			if @user && @user.authenticate(params[:session][:password])
				sign_in @user
				redirect_to root_path
			else
        		format.html { render action: 'new' }
        		format.json { render json: @user.errors, status: :unprocessable_entity }
      		end
      	end
	end

	# DELETE /sessions/current
	def destroy
		sign_out
		redirect_to root_path
	end
end
