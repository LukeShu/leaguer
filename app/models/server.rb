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

class Server < ActiveRecord::Base
	def default_user_abilities
		@abilities ||= User::Abilities.new(DefaultUser.new(self))
	end
	def default_user_abilities=(new)
		new.each do |k,v|
			if v == "0"
				v = false
			end
			default_user_abilities[k] = v
		end
	end
	class DefaultUser
		def initialize(server)
			@server = server
		end
		def can?(action)
			bit = User.permission_bits[action]
			if bit.nil?
				return false
			else
				return (@server.default_user_permissions & bit != 0)
			end
		end
		def add_ability(action)
			bit = User.permission_bits[action.to_sym]
			unless bit.nil?
				@server.default_user_permissions |= bit
			end
		end
		def remove_ability(action)
			bit = User.permission_bits[action.to_sym]
			unless bit.nil?
				@server.default_user_permissions &= ~ bit
			end
		end
	end
end
