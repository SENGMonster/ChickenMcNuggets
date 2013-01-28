class Poll < ActiveRecord::Base
  attr_accessible :title, :question, :exp_date, :creator_id, :poll_type_id, :category_id, :answer_possibilities_attributes, :chart_type, :start_date, :slug
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  has_many :answer_possibilities, :dependent => :destroy
  belongs_to :poll_type
  belongs_to :category
  belongs_to :creator
  has_many :answers
  has_many :comments
  
  accepts_nested_attributes_for :answer_possibilities, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  validates :question, :title, :poll_type_id, :category, :presence => true
  validate :validate_startdate
  validate :validate_expdate


  #Validierung - min 2 answerpossibilities

  def validate_startdate
  	if self.start_date < Date.today
  		errors.add(:start_date, ("Startdatum darf nicht in der Vergangenheit liegen."))
  	end
  end

  def validate_expdate
  	if self.exp_date <= self.start_date
  		errors.add(:exp_date, ("Enddatum muss hinter Startdatum liegen."))
  	end
  end

end