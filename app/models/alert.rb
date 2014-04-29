class Alert < ActiveRecord::Base
	belongs_to :author, class_name: "User"

	def owned_by?(user)
		self.author == user
	end
end
