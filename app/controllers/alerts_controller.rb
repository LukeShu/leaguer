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

class AlertsController < ApplicationController
	# GET /alerts
	# GET /alerts.json
	def index
		@alerts = Alert.all
	end

	# GET /alerts/1
	# GET /alerts/1.json
	def show
	end

	# GET /alerts/new
	def new
		@alert = Alert.new
	end

	# GET /alerts/1/edit
	def edit
	end

	# POST /alerts
	# POST /alerts.json
	def create
		@alert = Alert.new(alert_params)
		@alert.author = current_user
		users = {}
		users = User.all

		for i in 0..users.length
			current_user.send_message(users[i], @alert.message, "Pay Attention!")		
		end 

		respond_to do |format|
			if @alert.save
				format.html { redirect_to @alert, notice: 'Alert was successfully created.' }
				format.json { render action: 'show', status: :created, location: @alert }
			else
				format.html { render action: 'new' }
				format.json { render json: @alert.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /alerts/1
	# PATCH/PUT /alerts/1.json
	def update
		respond_to do |format|
			if @alert.update(alert_params)
				format.html { redirect_to @alert, notice: 'Alert was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @alert.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /alerts/1
	# DELETE /alerts/1.json
	def destroy
		@alert.destroy
		respond_to do |format|
			format.html { redirect_to alerts_url }
			format.json { head :no_content }
		end
	end

	private

	# Use callbacks to share common setup or constraints between actions.
	def set_alert
		@alert = Alert.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def alert_params
		params.require(:alert).permit(:author_id, :message)
	end
end
