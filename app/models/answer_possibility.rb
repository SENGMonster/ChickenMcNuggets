class AnswerPossibility < ActiveRecord::Base
  attr_accessible :value, :poll_id
  belongs_to :poll
  has_many :answers
end