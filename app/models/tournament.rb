# Copyright (C) 2014 Andrew Murrell
# Copyright (C) 2014 Davis Webb
# Copyright (C) 2014 Guntas Grewal
# Copyright (C) 2014 Luke Shumaker
# Copyright (C) 2014 Nathaniel Foy
# Copyright (C) 2014 Tomer Kimia
#
# This file is part of Leaguer.
#
# Leaguer is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Leaguer is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the Affero GNU General Public License
# along with Leaguer.  If not, see <http://www.gnu.org/licenses/>.

class Tournament < ActiveRecord::Base
	belongs_to :game

	has_many :tournament_stages
	# Don't validate presence of stages; sadly, it seems to break things
	#validates_presence_of :tournament_stages
	alias_attribute :stages, :tournament_stages

	has_many :brackets

	has_many :tournament_settings

	has_and_belongs_to_many :players, class_name: "User", association_foreign_key: "player_id", join_table: "players_tournaments"

	has_and_belongs_to_many :hosts,   class_name: "User", association_foreign_key: "host_id",   join_table: "hosts_tournaments"
	validates_presence_of :hosts

	validates_presence_of :game

	before_save { self.status ||= 0 }

	validates(:name,
		presence: true,
		length: {minimum: 5},
		uniqueness: {case_sensitive: true})

	validates(:min_players_per_team,
		presence: true,
		numericality: {
			only_integer: true,
			less_than_or_equal_to: :max_players_per_team,
		})
	validates(:max_players_per_team,
		presence: true,
		numericality: {
			only_integer: true,
			greater_than_or_equal_to: :min_players_per_team,
		})

	validates(:min_teams_per_match,
		presence: true,
		numericality: {
			only_integer: true,
			less_than_or_equal_to: :max_teams_per_match,
		})
	validates(:max_teams_per_match,
		presence: true,
		numericality: {
			only_integer: true,
			greater_than_or_equal_to: :min_teams_per_match,
		})

	validate :validate_scoring_method
	def validate_scoring_method
		(not self.scoring_method.try(:empty?)) and (scoring_methods.include? scoring_method)
	end

	def owned_by?(user)
		self.hosts.include?(user)
	end

	# Settings #################################################################

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
			tournament_setting = @tournament.tournament_settings.find{|s|s.name==setting_name}
			if tournament_setting.nil?
				return nil
			else
				return tournament_setting.value
			end
		end

		def []=(setting_name, val)
			tournament_setting = @tournament.tournament_settings.find{|s|s.name==setting_name}
			if tournament_setting.nil?
				game_setting = @tournament.game.settings.find_by_name(setting_name)
				@tournament.tournament_settings.build(name: setting_name, value: val,
					vartype:       game_setting.vartype,
					type_opt:      game_setting.type_opt,
					description:   game_setting.description,
					display_order: game_setting.display_order)
			else
				tournament_setting.value = val
			end
		end

		def keys
			@tournament.tournament_settings.all.collect { |x| x.name }
		end

		def empty?() keys.empty? end
		def count() keys.count end
		def length() count end
		def size() count end

		def method_missing(name, *args)
			if name.to_s.ends_with?('=')
				self[name.to_s.sub(/=$/, '').to_s] = args.first
			else
				return self[name.to_s]
			end
		end
	end

	# Joining/Leaving ##########################################################

	def joinable_by?(user)
		return (status==0 and user.can?(:join_tournament) and !players.include?(user))
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

	# Configured methods #######################################################

	def scoring
		@scoring ||= "Scoring::#{self.scoring_method.camelcase}".constantize
	end

	# Options for configured methods/modules ###################################
	# We're conflicted about whether these should be `self.` or not. ###########

	def self.scoring_methods
		make_methods "scoring"
	end
	def scoring_methods
		self.class.scoring_methods
	end

	def sampling_methods
		self.class.make_methods("sampling").select do |name|
			"Sampling::#{name.camelcase}".constantize.works_with?(self.game)
		end
	end

	def self.scheduling_methods
		make_methods "scheduling"
	end
	def scheduling_methods
		self.class.scheduling_methods
	end

	def self.seeding_methods
		make_methods "seeding"
	end
	def seeding_methods
		self.class.seeding_methods
	end

	private
	def self.make_methods(dir)
		@methods ||= {}
		if @methods[dir].nil? or Rails.env.development?
			@methods[dir] = Dir.glob("#{Rails.root}/lib/#{dir}/*.rb").map{|filename| File.basename(filename, ".rb") }
		end
		return @methods[dir]
	end
end
