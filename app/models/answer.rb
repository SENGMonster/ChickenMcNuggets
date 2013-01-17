class Answer < ActiveRecord::Base
  attr_accessible :browser, :os, :ip, :value, :answer_possibility_id, :poll_id, :guid, :comment_id
  belongs_to :answer_possibility
  belongs_to :poll
  belongs_to :comment

  #validates :value, :presence => true
end