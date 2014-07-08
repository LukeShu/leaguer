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

require 'user'

module SessionsHelper
	def sign_in(user)
		session = Session.new(user: user)
		raw_token = session.create_token
		session.save!

		token = Session.hash_token(raw_token)
		cookies.permanent[:remember_token] = { value: raw_token, expires: 20.minutes.from_now.utc }
	end

	def current_session
		Session.find_by(token: Session.hash_token(cookies[:remember_token]))
	end

	# sets the @current_user instance varable to the user corresponding
	# to the remember token, but only if @current_user is undefined
	# since the remember token is hashed, we need to hash the cookie
	# to find match the remember token
	def current_user
		return (current_session.nil? ? User::NilUser.new : current_session.user)
	end

	# checks if someone is currently signed in
	def signed_in?
		!current_user.nil?
	end

	def sign_out
		if signed_in?
			current_session.destroy
		end
		cookies.delete(:remember_token)
	end

	# This is for anyone that cares about how long a user is signed
	# in:
	#
	# Currently I have a user to be signed in forever unless they
	# log out (cookies.permanent....).
	#
	# If you want to change that, change line 7 to this:
	#
	# cookies[:remember_token] = { value: remember_token,
	#                             expires: 20.years.from_now.utc }
	#
	# which will expire the cookie in 20 years from its date of
	# creation.
	#
	# Oddly enough, this line above is equivalent to the:
	#
	# cookies.permanent
	#
	# This is just a short cut for this line since most people
	# create permanent cookies these days.
	#
	# Other times are:
	#
	# 10.weeks.from_now
	#
	# 5.days.ago
	#
	# etc...
end
