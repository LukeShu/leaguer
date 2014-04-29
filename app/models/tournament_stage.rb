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
