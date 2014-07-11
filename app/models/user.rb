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

class User < ActiveRecord::Base
	def owned_by?(tuser)
		self == tuser
	end
	##################################################################
	# Relationships                                                  #
	##################################################################
	has_and_belongs_to_many :tournaments_played, class_name: "Tournament", foreign_key: "player_id", join_table: "players_tournaments"
	has_and_belongs_to_many :tournaments_hosted, class_name: "Tournament", foreign_key: "host_id", join_table: "hosts_tournaments"
	has_and_belongs_to_many :teams
	has_many :sessions
	has_many :statistics
	has_many :remote_usernames

	##################################################################
	# Attributes                                                     #
	##################################################################

	# name:string
	validates(:name, presence: true, length: { maximum: 50 })

	# email:string:uniq
	before_save { self.email = email.downcase }
	validates(:email,
		presence: true,
		# This regex is taken from http://www.w3.org/TR/html5/forms.html#e-mail-state-%28type=email%29
		format: { with: /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/ },
		uniqueness: { case_sensitive: false })

	# user_name:string_uniq
	validates(:user_name,
		presence: true,
		length:{maximum: 50},
		format: {with: /\A[a-zA-Z0-9_-]+\z/},
		uniqueness: {case_sensitive: false })

	# password_digest:string
	has_secure_password validations: false # maps :password and :password_confirmation to :password_digest 
	validates(:password,
		length: { minimum: 6 },
		confirmation: true,
		unless: Proc.new { |u| u.password.try(:empty?) and not u.password_digest.try(:empty?) })

	# permissions:integer
	before_save { self.permissions ||= Server.first.default_user_permissions }

	##################################################################
	# XXX: hard-coded-ish. It makes me feel dirty.                   #
	##################################################################
	apply_simple_captcha
	acts_as_messageable
	def mailboxer_email(object)
		return nil
	end

	##################################################################
	# remote_usernames                                               #
	##################################################################

	def set_remote_username(game, data)
		remote = self.remote_usernames.where(:game => game).first
		if remote.nil?
			self.remote_usernames.create(game: game, value: data)
		else
			remote.value = data
			remote.save
		end
	end

	def get_remote_username(game)
		obj = self.remote_usernames.where(:game => game).first
		if obj.nil?
			if game.parent.nil?
				return nil
			else
				return get_remote_username(game.parent)
			end
		else
			return obj.value
		end
	end

	##################################################################
	# Permissions                                                    #
	##################################################################

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

			:create_bracket => (2**21),
			:edit_bracket => (2**22),
			:delete_bracket => (2**23)
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
o			@user = user
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

	##################################################################
	# Null-object pattern                                            #
	##################################################################

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
