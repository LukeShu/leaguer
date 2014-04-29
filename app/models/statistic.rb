class Statistic < ActiveRecord::Base
	belongs_to :user
	belongs_to :match

	validates(:name, presence: true, length: { minimum: 1 })

	def value
		begin
			return JSON::restore(self.json_value)
		rescue
			return {}
		end
	end

	def value=(v)
		self.json_value = v.to_json
	end

	after_save :update_match
	def update_match
		ActiveRecord::Base.transaction do
			if (self.name == "win") and (self.value)
				self.match.winner = self.match.teams.find{|t| t.users.include? self.user}
			end
			if 	(self.match.status == 2) and (self.match.finished?)
				#self.match.tournament_stage.scoring.score(self.match)
				self.match.status = 3
			end
			self.match.save!
		end
	end
end
