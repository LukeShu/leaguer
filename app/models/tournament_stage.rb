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
		return @scheduling.graph
	end

	private
	def set_scheduling
		if @scheduling.nil?
			require "scheduling/#{self.scheduling}"
			@scheduling = "Scheduling::#{self.scheduling.capitalize}".constantize.new(self)
		end
		return @scheduling
	end
end
