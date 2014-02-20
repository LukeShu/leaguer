class TeamMatchPair < ActiveRecord::Base
  belongs_to :team
  belongs_to :match
end
