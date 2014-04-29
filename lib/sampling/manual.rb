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
			@stats = @match.stats_from(self.class)

			require 'erb'
			erb_filename = File.join(__FILE__.sub(/\.rb$/, '.html.erb'))
			erb = ERB.new(File.read(erb_filename))
			erb.filename = erb_filename
			return erb.result(binding).html_safe
		end

		def handle_user_interaction(user, params)
			# => Save sampling_params as statistics
			require 'pp'
			puts('>'*80)
			pp @match
			puts('>'*80)
			if (@match.tournament_stage.tournament.hosts.include? user)
				manual_params = params.require(:manual)
				winner = Team.find(manual_params[:winner])
				@match.users.each do |user|
					puts('>'*80)
					pp "MAKING statistics BIIIIIIIITCH"
					puts('>'*80)
					Statistic.create(match: @match, user: user,
					                 name: "win", value: winner.users.include?(user))
					@match.stats_from(self.class).reject{|s|s=="win"}.each do |stat|
						Statistic.create(match: @match, user: user,
						                 name: stat, value: manual_params[:statistics][user.id][stat].to_i)
					end # stats
				end # users
			end # permission
		end # def

	end
end
