class SessionsController < ApplicationController

	def new
		if @user.nil?
			@user = User.new
		end
	end
	
	# find the user and create a new session
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
			sign_in @user
		  redirect_to root_path
    else
		  redirect_to signin_path
	end
  end

	def destroy
    	sign_out
    	redirect_to root_path
	end

end
