require 'user'

module SessionsHelper
	def sign_in(user)
		@session = Session.new(user: user)
		raw_token = @session.create_token
		@session.save # FIXME: error handling

		@token = Session.hash_token(raw_token)
		cookies.permanent[:remember_token] = { value: raw_token, expires: 20.minutes.from_now.utc }

		#set the current user to be the given user
		@current_user = user
	end

	# sets the @current_user instance virable to the user corresponding
	# to the remember token, but only if @current_user is undefined
	# since the remember token is hashed, we need to hash the cookie
	# to find match the remember token
	def current_user
		@token ||= Session.hash_token(cookies[:remember_token])
		@session ||= Session.find_by(token: @token)
		@current_user ||= (@session.nil? ? NilUser.new : @session.user)
	end

	# checks if someone is currently signed in
	def signed_in?
		!current_user.nil?
	end

	def sign_out
		if signed_in?
			@session.destroy
		end
		@current_user = NilUser.new
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
