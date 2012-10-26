class Poll < ActiveRecord::Base
  attr_accessible :title, :question, :exp_date, :user_id, :poll_type_id
  has_many :answer_possibilities
  belongs_to :poll_type
end