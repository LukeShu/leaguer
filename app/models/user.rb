class User < ActiveRecord::Base

	before_save { self.email = email.downcase }
	before_save { self.user_name = user_name }

	##
	# Rails looks for the create_remember_token and runs the method
	# before anything else.
	#
	# This method cannot be called by a user since it is denoted
	# as private.
	before_create :create_remember_token

	def in_group?(group)
		case group
		when :admin
			return ((groups & 2) != 0)
		when :host
			return ((groups & 1) != 0)
		when :player
			return true
		when :specator
			return true
		else
			return false
		end
	end

	def join_groups(join=[])
		# FIXME: race condition
		join.each do |group|
			case group
			when :admin
				groups |= 2
			when :host
				groups |= 1
			else
			end
		end
	end

	def leave_groups(leave=[])
		# FIXME: race condition
		leave.each do |group|
			case group
			when :admin
				groups &= ~ 2
			when :host
				groups &= ~ 1
			else
			end
		end
	end

	##
	# VAILD_EMAIL is the regex used to validate a user given email.
	VALID_EMAIL_REG = /\A\S+@\S+\.\S+\z/i

	##
	# VALID_USER_NAME checks to make sure a user's user_name
	# is in the proper format.
	VALID_USER_NAME_REG = /\A[a-zA-Z0-9\-]+\z/

	##
	# The following lines put a user account through a series of
	# validations in order to make sure all of their information
	# is in the proper format.
	#
	#     validates :symbol_to_be_validated
	#
	# - presence: determines whether or not a symbol is filled or not
	# - length: ensures there is a length limit on the symbol
	# - format: checks the format of given information to ensure
	#   validity
	validates(:name, presence: true, length: { maximum: 50 })
	validates(:email, presence: true, format: {with:
			VALID_EMAIL_REG},
		uniqueness: { case_sensitive: false })
	validates(:user_name, presence: true, length:{maximum: 50},
		format: {with: VALID_USER_NAME_REG },
		uniqueness: {case_sensitive: false })

	##
	# Instead of adding password and password_confirmation
	# attributes, requiring the presence of a password,
	# requiring that pw and pw_com match, and add an authenticate
	# method to compare an encrypted password to the
	# password_digest to authenticate users, I can just add
	# has_secure_password which does all of this for me.
	has_secure_password

	validates :password, length: { minimum: 6 }

	##
	# Create a random remember token for the user. This will be
	# changed every time the user creates a new session.
	#
	# By changing the cookie every new session, any hijacked sessions
	# (where the attacker steals a cookie to sign in as a certain
	# user) will expire the next time the user signs back in.
	#
	# The random string is of length 16 composed of A-Z, a-z, 0-9
	# This is the browser's cookie value.
	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	##
	# Encrypt the remember token.
	# This is the encrypted version of the cookie stored on
	# the database.
	#
	# The reasoning for storing a hashed token is so that even if
	# the database is compromised, the attacker won't be able to use
	# the remember tokens to sign in.
	def User.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	##
	# SHA-1 (Secure Hash Algorithm) is a US engineered hash
	# function that produces a 20 byte hash value which typically
	# forms a hexadecimal number 40 digits long.
	# The reason I am not using the Bcrypt algorithm is because
	# SHA-1 is much faster and I will be calling this on
	# every page a user accesses.
	#
	# https://en.wikipedia.org/wiki/SHA-1


	# Everything under private is hidden so you cannot call.
	private

	##
	# Create_remember_token in order to ensure a user always has
	# a remember token.
	def create_remember_token
		self.remember_token = User.hash(User.new_remember_token)
	end

	##
	# In order to ensure that someone did not accidentally submit
	# two accounts rapidly (which would throw off the validates
	# for user_name and email), I added an index to the Users
	# email and user_name in the database to ensure uniqueness
	# This also gives and index to the user_name and email
	# so finding a user SHOULD be easier for the database.
end
