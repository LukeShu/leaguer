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

class PmsController < ApplicationController
	# GET /pms
	# GET /pms.json
	def index
		@pms = Pm.all
	end

	# GET /pms/1
	# GET /pms/1.json
	def show
	end

	# GET /pms/new
	def new
		@pm = Pm.new
	end

	# GET /pms/1/edit
	def edit
	end

	# POST /pms
	# POST /pms.json
	def create
		@pm = Pm.new(pm_params)
		@pm.author = current_user
		@pm.recipient = User.find_by_user_name(pm_params['recipient_id'])

		@pm.conversation = @pm.author.send_message(@pm.recipient, @pm.message, @pm.subject).conversation

		respond_to do |format|
			if @pm.save
				format.html { redirect_to @pm, notice: 'Pm was successfully created.' }
				format.json { render action: 'show', status: :created, location: @pm }
			else
				format.html { render action: 'new' }
				format.json { render json: @pm.errors, status: :unprocessable_entity }
			end
		end
	end

	#def reply
	#	current_user.reply_to_conversation(conversation, message)
	#end

	# PATCH/PUT /pms/1
	# PATCH/PUT /pms/1.json
	def update
		respond_to do |format|
			if @pm.update(pm_params)
				format.html { redirect_to @pm, notice: 'Pm was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @pm.errors, status: :unprocessable_entity }
			end
		end
		current_user.reply_to_conversation(@pm.conversation, @pm.message)
	end

	# DELETE /pms/1
	# DELETE /pms/1.json
	def destroy
		@pm.destroy
		respond_to do |format|
			format.html { redirect_to pms_url }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_pm
		@pm = Pm.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def pm_params
		params.require(:pm).permit(:author_id, :recipient_id, :message, :subject, :conversation_id)
	end
end
