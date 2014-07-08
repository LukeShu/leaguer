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

class ServersController < ApplicationController
	# GET /server
	# GET /server.json
	def show
	end

	# GET /server/edit
	def edit
	end

	# PATCH/PUT /server
	# PATCH/PUT /server.json
	def update
		respond_to do |format|
			if @server.update(server_params)
				format.html { redirect_to edit_server_url, notice: 'Server was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @server.errors, status: :unprocessable_entity }
			end
		end
	end

	private

	# Use callbacks to share common setup or constraints between actions.
	def set_server
		@server = Server.first
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def server_params
		params.require(:server).permit(:default_user_permissions, :default_user_abilities => User.permission_bits.keys)
	end
end
