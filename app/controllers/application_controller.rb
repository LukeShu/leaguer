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

	include SimpleCaptcha::ControllerHelpers

	def check_permission(verb, object=nil)
		unless current_user.can?("#{verb.to_s}_#{noun}".to_sym) or object.try(:check_permission, current_user, verb)
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
end
