class User < ActiveRecord::Base
	has_and_belongs_to_many :tournaments_played, class_name: "Tournament", foreign_key: "player_id", join_table: "players_tournaments"
	has_and_belongs_to_many :tournaments_hosted, class_name: "Tournament", foreign_key: "host_id", join_table: "hosts_tournaments"
	has_and_belongs_to_many :teams
	has_many :sessions

	apply_simple_captcha

	before_save { self.email = email.downcase }
	before_save { self.user_name = user_name }

	def self.permission_bits
		return {
			:create_tournament	=> (2**1),
			:edit_tournament	=> (2**2),
			:join_tournament	=> (2**3),
			:delete_tournament	=> (2**4),

			:create_game	=> (2**5),
			:edit_game  	=> (2**6),
			:delete_game	=> (2**7),

			:create_user	=> (2**8),
			:edit_user  	=> (2**9),
			:delete_user	=> (2**10),

			:create_alert	=> (2**11),
			:edit_alert 	=> (2**12),
			:delete_alert	=> (2**13),

			:create_pm	=> (2**14),
			:edit_pm	=> (2**15),
			:delete_pm	=> (2**16),

			:create_session	=> (2**17),
			:delete_session	=> (2**18),

			:edit_permissions	=> (2**19),
			:edit_server    	=> (2**20),
		}
	end

	def can?(action)
		bit = User.permission_bits[action]
		if bit.nil?
			return false
		else
			return (self.permissions & bit != 0)
		end
	end

	def add_ability(action)
		bit = User.permission_bits[action.to_sym]
		unless bit.nil?
			self.permissions |= bit
		end
	end

	def remove_ability(action)
		bit = User.permission_bits[action.to_sym]
		unless bit.nil?
			self.permissions &= ~ bit
		end
	end


	# A representation of the permission bits as a mock-array.
	def abilities
		@abilities ||= Abilities.new(self)
	end
	def abilities=(new)
		new.each do |k,v|
			if v == "0"
				v = false
			end
			abilities[k] = v
		end
	end

	# A thin array-like wrapper around the permission bits to make it
	# easy to modify them using a form.
	class Abilities
		def initialize(user)
			@user = user
		end
		def [](ability)
			return @user.can?(ability)
		end
		def []=(ability, val)
			if val
				@user.add_ability(ability)
			else
				@user.remove_ability(ability)
			end
		end
		def keys
			User.permission_bits.keys
		end
		def method_missing(name, *args)
			if name.to_s.ends_with?('=')
				self[name.to_s.sub(/=$/, '').to_sym] = args.first
			else
				return self[name.to_sym]
			end
		end
	end

	# VAILD_EMAIL is the regex used to validate a user given email.
	VALID_EMAIL_REG = /\A\S+@\S+\.\S+\z/i

	# VALID_USER_NAME checks to make sure a user's user_name
	# is in the proper format.
	VALID_USER_NAME_REG = /\A[a-zA-Z0-9\-]+\z/

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

	# Instead of adding password and password_confirmation
	# attributes, requiring the presence of a password,
	# requiring that pw and pw_com match, and add an authenticate
	# method to compare an encrypted password to the
	# password_digest to authenticate users, I can just add
	# has_secure_password which does all of this for me.
	has_secure_password

	validates :password, length: { minimum: 6 }

	class NilUser
		def nil?
			return true
		end
		def can?(action)
			case action
			when :create_user
				return true
			when :create_session
				return true
			else
				return false
			end
		end
		def method_missing(name, *args)
			# Throw an error if User doesn't have this method
			super unless User.new.respond_to?(name)
			# User has this method -- return a blank value
			# 'false' if the method ends with '?'; 'nil' otherwise.
			name.to_s.ends_with?('?') ? false : nil
		end
	end
end
