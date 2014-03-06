class SessionsController < ApplicationController
	before_action :set_session, only: [:destroy]

	# GET /sessions/new
	def new
		@user = User.new
		#@session = Session.new
	end
	
	# POST /sessions
	# POST /sessions.json
	def create
		# find the user...

		@user = User.find_by(email: params[:session][:email])
		
		if @user.nil?
			@user = User.find_by_user_name(params[:session][:user_name]) 
		end

		#@session = Session.new(@user)
		# ... and create a new session
		respond_to do |format|
			if @user && @user.authenticate(params[:session][:password])
				sign_in @user
				format.html { redirect_to root_path }
				#format.json { #TODO }
			else
				format.html { render action: 'new' }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /sessions/1
	# DELETE /sessions/1.json
	def destroy
		#@session.destroy
		sign_out
		respond_to do |format|
			format.html { redirect_to root_path }
			format.json { head :no_content }
		end
	end

	private

			# Use callbacks to share common setup or constraints between actions.
			def set_session
				#@session = Session.find(cookies[:remember_token])
			end

			# Never trust parameters from the scary internet, only allow the white list through.
			def session_params
				params.require(:session).permit(:session_email, :session_user_name, :session_password)
			end
end
