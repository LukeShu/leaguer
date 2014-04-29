class Statistic < ActiveRecord::Base
	belongs_to :user
	belongs_to :match

	def value
		begin
			return JSON.parse(self.json_value)
		rescue
			return {}
		end
	end

	def value=(v)
		self.json_value = v.to_json
	end

	after_save :update_match
	def update_match
		if (self.name == "win") and (self.value > 0)
			self.match.winner = self.match.teams.find{|t| t.users.include? self.user}
		end
		if 	(self.match.status == 2) and (self.match.finished?)
			self.match.status = 3
		end
		self.match.save
	end
end
