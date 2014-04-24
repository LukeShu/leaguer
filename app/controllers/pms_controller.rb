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
		#require 'pp'
		#pp @pm.message
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
