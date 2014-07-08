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

class Session < ActiveRecord::Base
	belongs_to :user

	def owned_by?(tuser)
		self.user == tuser
	end

	##
	# Create a random remember token for the user. This will be
	# changed every time the user creates a new session.
	#
	# If you want this value, hang on to it; the raw value is
	# discarded afterward.
	#
	# By changing the cookie every new session, any hijacked sessions
	# (where the attacker steals a cookie to sign in as a certain
	# user) will expire the next time the user signs back in.
	#
	# The random string is of length 16 composed of A-Z, a-z, 0-9
	# This is the browser's cookie value.
	def create_token()
		t = SecureRandom.urlsafe_base64
		self.token = Session.hash_token(t)
		t
	end

	##
	# Encrypt the remember token.
	# This is the encrypted version of the cookie stored on
	# the database.
	#
	# The reasoning for storing a hashed token is so that even if
	# the database is compromised, the attacker won't be able to use
	# the remember tokens to sign in.
	def Session.hash_token(token)
		# SHA-1 (Secure Hash Algorithm) is a US engineered hash
		# function that produces a 20 byte hash value which typically
		# forms a hexadecimal number 40 digits long.
		# The reason I am not using the Bcrypt algorithm is because
		# SHA-1 is much faster and I will be calling this on
		# every page a user accesses.
		#
		# https://en.wikipedia.org/wiki/SHA-1
		Digest::SHA1.hexdigest(token.to_s)
	end
end
