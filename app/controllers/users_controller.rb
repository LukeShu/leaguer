# Copyright (C) 2014 Andrew Murrell
# Copyright (C) 2014 Davis Webb
# Copyright (C) 2014 Guntas Grewal
# Copyright (C) 2014 Luke Shumaker
# Copyright (C) 2014 Nathaniel Foy
# Copyright (C) 2014 Tomer Kimia
#
# This file is part of Leaguer.
#
# Leaguer is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Leaguer is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the Affero GNU General Public License
# along with Leaguer.  If not, see <http://www.gnu.org/licenses/>.

class UsersController < ApplicationController

	require 'httparty'
	require 'json'

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
		unless (true) # simple_captcha_valid?)
			respond_to do |format|
				format.html { render action: 'new', status: :unprocessable_entity }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
			return
		end

		respond_to do |format|
			if @user.save
				sign_in @user
				if @user.id == 1
					# This is the first user, so give them all the power
					@user.permissions = 0x7FFFFFFF
					@user.save
				end
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
		ok = true
		if params[:user][:remote_usernames].nil?
			ok &= @user.update(user_params)
		else
			params[:user][:remote_usernames].each do |game_name,user_name|
				game = Game.find_by_name(game_name)
				Sampling::RiotApi::set_remote_name(@user, game, user_name)
			end
		end
		respond_to do |format|
			if ok
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

	# Never trust parameters from the scary internet, only allow the white list through.
	def user_params
		permitted = [ :name, :email, :user_name, :password, :password_confirmation ]
		if current_user.can? :edit_permissions
			permitted.push(:abilities => User.permission_bits.keys)
		end
		params.require(:user).permit(permitted)
	end
end
