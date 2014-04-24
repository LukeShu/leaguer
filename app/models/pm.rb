class Pm < ActiveRecord::Base
	belongs_to :author
	belongs_to :recipient
	belongs_to :conversation
end
