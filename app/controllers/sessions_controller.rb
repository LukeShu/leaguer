class SessionsController < ApplicationController

	def new
	end
	
	# find the user and create a new session
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
			sign_in user
		  redirect_to root_path
    else
			render 'new'
    end
  end

	def destroy
    sign_out
    redirect_to root_path
	end

end
