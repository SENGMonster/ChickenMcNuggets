class Poll < ActiveRecord::Base
  attr_accessible :title, :questin, :exp_date, :user_id, :poll_type_id, :category_id
  has_many :answer_possibilities
  belongs_to :poll_type
  belongs_to :category
  
end