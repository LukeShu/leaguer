class Match < ActiveRecord::Base
  belongs_to :tournament

  has_and_belongs_to_many :teams

  belongs_to :winner

end
