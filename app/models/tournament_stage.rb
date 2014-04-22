class TournamentStage < ActiveRecord::Base
	belongs_to :tournament
	has_many :matches

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
		set_scheduling
		@scheduling.create_matches
	end

	def to_svg
		set_scheduling
		return @scheduling.graph(self)
	end

	private
	def set_scheduling
		@scheduling ||= "Scheduling::#{self.scheduling}".constantize.new(self)
	end
end
