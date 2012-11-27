class Poll < ActiveRecord::Base
  attr_accessible :title, :question, :exp_date, :user_id, :poll_type_id, :category_id, :answer_possibilities_attributes, :chart_type
  has_many :answer_possibilities, :dependent => :destroy
  belongs_to :poll_type
  belongs_to :category
  has_many :answers
  
  accepts_nested_attributes_for :answer_possibilities, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end