class PollController < ApplicationController
  before_filter :check_session, :only => [:vote]
  
  def show
    ##https://github.com/mattetti/googlecharts
    @poll=Poll.find(params[:id])
    @answers = Array.new
    @answer_possibilities = @poll.answer_possibilities
    
    Answer.all.each do |answer|
      @answer_possibilities.each do |answer_possibility|
        if answer_possibility.id == answer.answer_possibility_id
          @answers << answer
        end
      end
    end
    
  end

  def vote
     @poll=Poll.find(params[:id])
     @answer = Answer.new     
  end

  def process_vote
    @answer = Answer.new(params[:answer])
    @poll = Poll.find(params[:poll])
    @answer_possibility = AnswerPossibility.find(params[:answer][:id])
    @answer.answer_possibility_id = @answer_possibility.id
    @answer.value = @answer_possibility.value
    session[@poll.id] = 1
    respond_to do |format|
      if @answer.save
        format.html { redirect_to :action => "show", :id => @poll.id }
        format.json { render json: @poll, status: :created, location: @poll }
      else
        format.html { render action: "vote" }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end    
  end
  
  def check_session
    @poll=Poll.find(params[:id])
    if session[@poll.id]
      redirect_to :action => "show", :id => @poll.id
    end
  end
  
end
