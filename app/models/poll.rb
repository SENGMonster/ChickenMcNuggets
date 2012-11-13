class Poll < ActiveRecord::Base
  attr_accessible :title, :question, :exp_date, :user_id, :poll_type_id, :category_id, :answer_possibilities_attributes
  has_many :answer_possibilities
  belongs_to :poll_type
  belongs_to :category
  has_many :answers
  
  accepts_nested_attributes_for :answer_possibilities
end