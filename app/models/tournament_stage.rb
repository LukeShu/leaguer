class TournamentStage < ActiveRecord::Base
	belongs_to :tournament
	has_many :matches

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

	def make_methods(dir)
		if @methods[dir].nil? or Rails.env.development?
			@methods[dir] = Dir.glob("#{Rails.root}/lib/#{dir}/*.rb").map{|filename| filename.sub(/.*\/(.*)\.rb/, /\1/)}
		end
		return @methods[dir]
	end

	def scoring_methods
		make_methods "scoring"
	end

	def sampling_methods
		make_methods "sampling"
	end

	def scheduling_methods
		make_methods "scheduling"
	end

	def seeding_methods
		make_methods "seeding"
	end

	# Accessors to the configured methods

	def scoring
		@scoring ||= tournament.scoring
	end

	def sampling
		@sampling ||= tournament.sampling
	end

	def scheduling
		@scheduling ||= "Scheduling::#{self.scheduling_method.camelcase}".constantize.new(self)
	end

	def seeding
		@seeding ||= "Seeding::#{self.seeding_method.camelcase}".constantize.new(self)
	end
end
