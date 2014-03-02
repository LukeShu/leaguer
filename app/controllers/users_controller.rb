class UsersController < ApplicationController

	def new
	end

	def show
		@user = User.find(param[:id])
	end
end
