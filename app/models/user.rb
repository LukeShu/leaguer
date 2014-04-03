class User < ActiveRecord::Base
	has_and_belongs_to_many :tournaments_played, class_name: "Tournament", foreign_key: "player_id", join_table: "players_tournaments"
	has_and_belongs_to_many :tournaments_hosted, class_name: "Tournament", foreign_key: "host_id", join_table: "hosts_tournaments"
	has_and_belongs_to_many :teams
	has_many :sessions

	apply_simple_captcha

	before_save { self.email = email.downcase }
	before_save { self.user_name = user_name }

	def after_initialize
		self.permissions = 0
	end

	def in_group?(group)
		case group
		when :admin
			return ((groups & 2) != 0)
		when :host
			return true #((groups & 1) != 0)
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
end
