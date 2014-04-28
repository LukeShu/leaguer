module Sampling
	class PeerReview
		def self.works_with?(game)
			return true
		end

		def self.can_get?(setting_name)
			return setting_name.start_with?("feedback_from_")
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
			@user = user
			@team = get_team(match)
			@feedbacks_missing = get_feedbacks_missing(match)

			require 'erb'
			erb_filename = File.join(__FILE__.sub(/\.rb$/, '.svg.erb'))
			erb = ERB.new(File.read(erb_filename))
			erb.filename = erb_filename
			return erb.result.html_safe
		end

		def handle_user_interaction(reviewing_user, params)
			i = 0
			params[:peer_review].to_s.split(',').each do |user_name|
				reviewed_user = User.find_by_user_name(user_name)
				user.statistics.create(match: @match, value: i)
				i += 1
			end
		end

		private

		def self.get_users(match)
			users = []
			match.teams.each{|t| users.concat(t.users)}
			return users
		end

		def self.get_team(match)
			match.teams.find{|t|t.users.include?(@user)}
		end

		def self.get_feedbacks(match)
			ret = {}
			match.statistiscs.where("'name' LIKE 'feedback_from_%'").each do |statistic|
				ret[statistic.user] ||= {}
				ret[statistic.user][User.find_by_user_name(statistic.name.sub(/^feedback_from_/,''))] = statistic.value
			end
			return ret
		end

		def self.get_feedbacks_missing(match)
			require 'set'
			ret = Set.new()

			feedback = get_feedbacks(match)
			users = get_users(match)

			feedback.each do |feedback|
				(users - feedback.keys).each do |user|
					ret.push(user)
				end
			end

			return ret
		endx
	end
end
