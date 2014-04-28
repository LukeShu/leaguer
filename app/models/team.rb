class Team < ActiveRecord::Base
	has_and_belongs_to_many :matches
	has_and_belongs_to_many :users

	alias_attribute :players, :users
end
