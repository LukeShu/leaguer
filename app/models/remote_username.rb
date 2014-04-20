class RemoteUsername < ActiveRecord::Base
	belongs_to :game
	belongs_to :user

	def value
		JSON.parse(self.json_value)
	end

	def value=(v)
		self.json_value = v.to_json
	end
end
