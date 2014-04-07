class Tournament < ActiveRecord::Base
	belongs_to :game
	has_many :matches
	has_many :preferences_raw, class_name: "TournamentPreference"
	has_and_belongs_to_many :players, class_name: "User", association_foreign_key: "player_id", join_table: "players_tournaments"
	has_and_belongs_to_many :hosts,   class_name: "User", association_foreign_key: "host_id",   join_table: "hosts_tournaments"

	def preferences
		@preferences ||= Preferences.new(self)
	end
	def preferences=(pref)
		pref.each do |key, value|
			value = false if valuedd == "0"
			preferences[key] = value
		end
	end

	class Preferences
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

                def [](preference)
                        p = @tournament.preferences_raw.find_by_name(preference)
                        if p.nil?
                                return nil
                        else
                                return p.value
                        end
                end

                def []=(preference, val)
                        p = @tournament.preferences_raw.find_by_name(preference)
                        if p.nil?
				TournamentPreference.create( tournament_id: @tournament.id, vartype: get_type(val), name: preference, value: val )
                        else
                                p.value = val
                        end
                end

		def get_type(val) {
			return vartypes[:true_false] if val == "true" or val == "false"
			return vartypes[:range] if /\d+-\d+/ =~ val
			return vartypes[:integer] if /\d+/ =~ val
			return vartypes[:select] if /,/ =~ val
			return vartypes[:string]
		}

                def keys
                        @tournament.preferences_raw.all.collect { |x| x.name }
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
			self.matches.create(name: "Match #{i}", status: 0)
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
