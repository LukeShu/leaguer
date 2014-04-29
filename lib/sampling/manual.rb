module Sampling
	class Manual
		def self.works_with?(game)
			return true
		end

		def self.can_get?(setting_name)
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
			@tournament = @match.tournament_stage.tournament
			@current_user = user
			@users = @match.users
			@stats = @match.stats_from(self.class)

			require 'erb'
			erb_filename = File.join(__FILE__.sub(/\.rb$/, '.html.erb'))
			erb = ERB.new(File.read(erb_filename))
			erb.filename = erb_filename
			return erb.result(binding).html_safe
		end

		def handle_user_interaction(user, sampling_params)
			# => Save sampling_params as statistics
			sampling_params.select {|name, value| @match.stats_from(self.class).include? name }.each do |name, value|
				Statistic.create(name: value, user: user, match: @match)
			end
		end
	end
end
