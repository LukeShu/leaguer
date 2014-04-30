class Pm < ActiveRecord::Base
	belongs_to :author, class_name: "User"
	belongs_to :recipient, class_name: "User"
	belongs_to :conversation

	def name
		return current_user.name
	end

	def owned_by?(user)
		self.author == user
	end

=begin
	def mailboxer_email(email)
		return current_user.email
	end
=end
end
