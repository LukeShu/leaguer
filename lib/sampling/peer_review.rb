module Sampling
	class PeerReview
		def self.works_with?(game)
			return true
		end

		def self.can_get?(setting_name)
			return setting_name.start_with?("review_from_") ? 2 : 0
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
			@reviews_missing = get_reviews_missing(match)

			require 'erb'
			erb_filename = File.join(__FILE__.sub(/\.rb$/, '.html.erb'))
			erb = ERB.new(File.read(erb_filename))
			erb.filename = erb_filename
			return erb.result(binding).html_safe
		end

		def handle_user_interaction(reviewing_user, params)
			i = 0
			params[:peer_review].to_s.split(',').each do |user_name|
				reviewed_user = User.find_by_user_name(user_name)
				reviewed_user.statistics.create(match: @match, name: "review_from_#{reviewing_user.user_name}", value: i)
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

		def self.get_reviews(match)
			ret = {}
			match.statistiscs.where("'name' LIKE 'review_from_%'").each do |statistic|
				ret[statistic.user] ||= {}
				ret[statistic.user][User.find_by_user_name(statistic.name.sub(/^review_from_/,''))] = statistic.value
			end
			return ret
		end

		def self.get_reviews_missing(match)
			require 'set'
			ret = Set.new

			review = get_reviews(match)
			users = get_users(match)

			review.each do |review|
				(users - review.keys).each do |user|
					ret.add(user)
				end
			end

			return ret
		end
	end
end
