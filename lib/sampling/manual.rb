module Sampling
	module Manual
		def self.works_with?(game)
			return true
		end

		def can_get?(user, setting_name)
			return 1
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

		def self.sampling_start(match, statistics)
			# do nothing
		end

		def self.render_user_interaction(match, user)
			# TODO

			require 'erb'
			erb_filename = File.join(__FILE__.sub(/\.rb$/, '.svg.erb'))
			erb = ERB.new(File.read(erb_filename))
			erb.filename = erb_filename
			return erb.result.html_safe
		end

		def self.handle_user_interaction(match, user, sampling_params)
			# TODO
			#match.statistics.create(user: nil, name: "blowout",
		end
	end
end
