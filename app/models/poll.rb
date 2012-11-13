class Poll < ActiveRecord::Base
  attr_accessible :title, :question, :exp_date, :user_id, :poll_type_id, :category_id
  has_many :answer_possibilities
  belongs_to :poll_type
  belongs_to :category
  has_many :answers
  
end