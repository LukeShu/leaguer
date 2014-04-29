module ActiveRecord
	class Base
		def check_permission(user, verb)
			user.can?("#{verb.to_s}_#{self.class.name.underscore}".to_sym) or self.owned_by?(user)
		end

		def owned_by?(user)
			return false
		end
	end
end
