class SessionsController < ApplicationController

	# GET /sessions/new
	def new
	end

	# POST /sessions
	# POST /sessions.json
	def create
		# find the user...
		user = User.find_by_email(params[:username_or_email].to_s) || User.find_by_user_name(params[:username_or_email].to_s)

		#@session = Session.new(@user)
		# ... and create a new session
		respond_to do |format|
			if user && user.authenticate(params[:password].to_s)
				sign_in user
				format.html { redirect_to root_path, notice: "Welcome, #{user.name}" } # TODO; previous URL
				#format.json { # TODO }
			else
				format.html { render action: 'new' }
				format.json { render json: user.errors, status: :unprocessable_entity }
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

	# Only allow creating a session if not logged in.
	def check_create
		unless current_user.nil?
			respond_to do |format|
				format.html { redirect_to root_path, notice: "You are already logged in" } # TODO: previous URL
				format.json { render json: {"errors" => ["already logged in"]}, status: :forbidden }
			end
		end
	end

	def check_delete
		unless signed_in?
			respond_to do |format|
				format.html { redirect_to root_path, notice: "You are not logged in" } # TODO: previous URL
				format.json { render json: {"errors" => ["not logged in"]}, status: :forbidden }
			end
		end
	end
end
