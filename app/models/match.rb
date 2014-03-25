class Match < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :winner
end
