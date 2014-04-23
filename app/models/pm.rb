class Pm < ActiveRecord::Base
	belongs_to :author, class_name: "User"
	belongs_to :recipient, class_name: "User"

	def name
		return current_user.name
	end

=begin
	def mailboxer_email(email)
		return current_user.email
	end
=end
end
