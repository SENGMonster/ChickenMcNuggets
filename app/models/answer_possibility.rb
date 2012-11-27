class AnswerPossibility < ActiveRecord::Base
  attr_accessible :value, :poll_id
  has_one :poll
  has_many :answers 
end