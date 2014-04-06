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
				format.html { redirect_to @server, notice: 'Server was successfully updated.' }
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
		params.require(:server).permit(:default_user_permissions)
	end
end
