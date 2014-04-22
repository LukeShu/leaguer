class Tournament < ActiveRecord::Base
	belongs_to :game
	has_many :matches
	has_many :settings_raw, class_name: "TournamentSetting"
	has_and_belongs_to_many :players, class_name: "User", association_foreign_key: "player_id", join_table: "players_tournaments"
	has_and_belongs_to_many :hosts,   class_name: "User", association_foreign_key: "host_id",   join_table: "hosts_tournaments"

	def matches_ordered
		h = {}
		i = 1
		matches.order(:id).each do |m|
			h[i] = m
			i += 1
		end
		return h
	end

	def settings
		@settings ||= Settings.new(self)
	end
	def settings=(setting)
		setting.each do |key, value|
			value = false if value == "0"
			settings[key] = value
		end
	end

	class Settings
		@vartypes = {
			:true_false => 0,
			:integer => 1,
			:string => 2,
			:select => 3,
			:range => 4
		}

		def initialize(tournament)
			@tournament = tournament
		end

		def [](setting_name)
			tournament_setting = @tournament.settings_raw.find_by_name(setting_name)
			if tournament_setting.nil?
				return nil
			else
				return tournament_setting.value
			end
		end

		def []=(setting_name, val)
			tournament_setting = @tournament.settings_raw.find_by_name(setting_name)
			if tournament_setting.nil?
				game_setting = @tournament.game.settings.find_by_name(setting_name)
				@tournament.settings_raw.create(name: setting, value: val,
					vartype: game_setting.vartype,
					type_opt: game_setting.type_opt,
					description: game_setting.description,
					display_order: game_setting.display_order)
			else
				tournament_setting.value = val
			end
		end

		def keys
			@tournament.settings_raw.all.collect { |x| x.name }
		end

		def method_missing(name, *args)
			if name.to_s.ends_with?('=')
				self[name.to_s.sub(/=$/, '').to_sym] = args.first
			else
				return self[name.to_sym]
			end
		end
	end

	def open?
		return true
	end

	def joinable_by?(user)
		return (open? and user.can?(:join_tournament) and !players.include?(user))
	end

	def join(user)
		unless joinable_by?(user)
			return false
		end
		players.push(user)
	end

	def leave(user)
		if players.include?(user) && status == 0
			players.delete(user)
		end
	end

	def setup
		num_teams = (self.players.count/self.min_players_per_team).floor
		num_matches = num_teams - 1
		for i in 1..num_matches
			self.matches.create(name: "Match #{i}", status: 0, submitted_peer_evaluations: 0)
		end
		match_num = num_matches-1
		team_num = 0
		#for each grouping of min_players_per_team
		players.each_slice(min_players_per_team) do |players|

			#if the match is full, move to the next match, otherwise move to the next team
			if (team_num == min_teams_per_match)
				match_num -= 1
				team_num = 0
			else
				team_num += 1
			end
			#create a new team in the current match
			self.matches[match_num].teams.push(Team.create(users: players))
		end
	end
end
