class PollType < ActiveRecord::Base
  attr_accessible :name
  has_many :polls
end