class PollCreation < ActiveRecord::Base
  attr_accessible :category_id, :chart_type, :exp_date, :poll_type_id, :question, :title
end
