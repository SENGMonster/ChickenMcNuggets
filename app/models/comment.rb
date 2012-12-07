class Comment < ActiveRecord::Base
  attr_accessible :text, :poll_id
  has_many :answers
  belongs_to :poll
end