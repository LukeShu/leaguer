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

class TournamentStage < ActiveRecord::Base
	belongs_to :tournament
	validates_presence_of :tournament

	has_many :matches

	validates(:scheduling_method,
		presence: true,
		inclusion: {in: Tournament.new.scheduling_methods})

	validates(:seeding_method,
		presence: true,
		inclusion: {in: Tournament.new.seeding_methods})

	def owned_by?(user)
		self.tournament.owned_by?(user)
	end

	# A 1-indexed hash of matches
	def matches_ordered
		h = {}
		i = 1
		self.matches.order(:id).each do |m|
			h[i] = m
			i += 1
		end
		return h
	end

	def create_matches
		scheduling.create_matches
	end

	def to_svg(highlight_user)
		return scheduling.graph(highlight_user)
	end

	def seed
		return seeding.seed.pair(matches, players)
	end

	# Accessors to the configured methods

	def scoring
		@scoring ||= tournament.scoring
	end

	def scheduling
		@scheduling ||= "Scheduling::#{self.scheduling_method.camelcase}".constantize.new(self)
	end

	def seeding
		@seeding ||= "Seeding::#{self.seeding_method.camelcase}".constantize
	end
end
