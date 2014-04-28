module Sampling
	class Manual
		def self.works_with?(game)
			return true
		end

		def can_get?(setting_name)
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

		####

		def initialize(match)
			@match = match
		end

		def start
			# do nothing
		end

		def render_user_interaction(user)
			@current_user = user
			@users = @match.users
			@stats = @match.stats_from(self.class)

			require 'erb'
			erb_filename = File.join(__FILE__.sub(/\.rb$/, '.svg.erb'))
			erb = ERB.new(File.read(erb_filename))
			erb.filename = erb_filename
			return erb.result.html_safe
		end

		def handle_user_interaction(user, sampling_params)
			# TODO
		end
	end
end
