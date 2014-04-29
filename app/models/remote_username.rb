class RemoteUsername < ActiveRecord::Base
	belongs_to :game
	belongs_to :user

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
end      
