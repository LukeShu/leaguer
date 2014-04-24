class Tournament < ActiveRecord::Base
	belongs_to :game
	has_many :tournament_stages
	has_many :settings_raw, class_name: "TournamentSetting"
	has_and_belongs_to_many :players, class_name: "User", association_foreign_key: "player_id", join_table: "players_tournaments"
	has_and_belongs_to_many :hosts,   class_name: "User", association_foreign_key: "host_id",   join_table: "hosts_tournaments"

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
end
