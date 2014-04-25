module Sampling
	module HostEntry
		def self.works_with?(game)
			return true
		end

		def self.uses_remote?
			return false
		end

		def self.set_remote_name(user, game, value)
			raise "This sampling method doesn't use remote usernames."
		end

		def self.get_remote_name(value)
			raise "This sampling method doesn't use remote usernames."
		end

		def self.sampling_start(match)
			# TODO
		end

		def self.sampling_done?(match)
			# TODO
		end

		def self.render_user_interaction(match, user)
			
		end

		def self.handle_user_interaction(match, user, sampling_params)
			match.statistics.create(user: nil, name: "blowout", 
		end
	end
end
