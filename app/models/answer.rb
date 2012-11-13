class Answer < ActiveRecord::Base
  attr_accessible :browser, :os, :ip, :value, :answer_possibility_id, :poll_id
  belongs_to :answer_possibility
  belongs_to :poll
end