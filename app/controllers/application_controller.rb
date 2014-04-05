class ApplicationController < ActionController::Base
	before_action :set_object, only: [:show]
	before_action :check_create, only: [:new, :create]
	before_action :check_edit, only: [:edit, :update]
	before_action :check_delete, only: [:destroy]

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	#include sessionhelper for the session controller and view
	include SessionsHelper

	def check_permission(verb, object=nil)
		unless current_user.can?((verb.to_s+"_"+noun).to_sym) or (!object.nil? and is_owner?(object))
			respond_to do |format|
				format.html do
					if object.nil?
						redirect_to send(noun.pluralize+"_url"), notice: "You don't have permission to #{verb} #{noun.pluralize}."
					else
						redirect_to object, notice: "You don't have permission to #{verb} this #{noun}."
					end
				end
				format.json { render json: "Permission denied", status: :forbidden }
			end
		end
	end

	def noun
		@noun ||= self.class.name.underscore.sub(/_controller$/, '').singularize
	end

	def set_object
		object = send("set_"+noun)
	end

	def check_create
		check_permission(:create)
	end
	def check_edit
		object = send("set_"+noun)
		check_permission(:edit, object)
	end
	def check_delete
		object = send("set_"+noun)
		check_permission(:edit, object)
	end

	# Override this
	def is_owner?(object)
		return false
	end
end
