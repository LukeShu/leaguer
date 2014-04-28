class Match < ActiveRecord::Base
	belongs_to :tournament_stage
	has_many :statistics
	has_and_belongs_to_many :teams

	belongs_to :winner, class_name: "Team"

	def win?(player)
		winner.players.include? player
	end

	def handle_sampling(params)
		# TODO
	end

	def render_sampling(user)
		# TODO
	end

	def finished?
		# TODO
	end
end
