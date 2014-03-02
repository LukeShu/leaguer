class SessionsController < ApplicationController

	def new
	end
	
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
			sign_in user
			#redirect goes here
    else
			render 'new'
    end
  end

	def destroy

    sign_out

  #I dont know where to redirect to so yeah
  #  redirect_to sign_in

	end

end
