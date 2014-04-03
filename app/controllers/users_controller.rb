class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :perms_edit, only: [:edit, :update, :destroy]
	before_action :perms_create, only: [:new, :create]

	# GET /users
	# GET /users.json
	def index
		@users = User.all
	end

	# GET /users/1
	# GET /users/1.json
	def show
	end

	# GET /users/new
	def new
		@user = User.new
	end

	# GET /users/1/edit
	def edit
	end

	# POST /users
	# POST /users.json
	def create
		@user = User.new(user_params)
		@user.groups = 0
		respond_to do |format|
			if @user.save
				sign_in @user
				format.html { redirect_to root_path, notice: 'User was successfully created.' }
				format.json { render action: 'show', status: :created, location: @user }
			else
				format.html { render action: 'new', status: :unprocessable_entity }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /users/1
	# PATCH/PUT /users/1.json
	def update
		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to @user, notice: 'User was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /users/1
	# DELETE /users/1.json
	def destroy
		@user.destroy
		respond_to do |format|
			format.html { redirect_to users_url }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.find(params[:id])
	end

	def perms_edit
		unless (current_user == @user) or (signed_in? and current_user.in_group? :admin)
			respond_to do |format|
				format.html { render action: 'permission_denied', status: :forbidden }
				format.json { render json: "Permission denied", status: :forbidden }
			end
		end
	end

	def perms_create
		if signed_in?
			respond_to do |format|
				format.html { render action: 'already_signed_in', status: :unprocessable_entity }
				format.json { render json: "Already signed in", status: :unprocessable_entity }
			end
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def user_params
		params.require(:user).permit(:name, :email, :user_name, :password, :password_confirmation)
	end
end
