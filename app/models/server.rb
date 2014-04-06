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
