class PollController < ApplicationController
  #before_filter :check_session, :only => [:vote]
  
  def show
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

  def process_multiple_vote  
    @poll = Poll.find(params[:poll])
    @answer_ids = params[:answer_ids]
    
    @answer_ids.each do |answer_id|
      @answer = Answer.new(params[:answer])
      @answer.answer_possibility_id = AnswerPossibility.find(answer_id).id
      @answer.value =AnswerPossibility.find(answer_id).value
      @answer.save      
    end
    session[@poll.id] = 1
    redirect_to :action => "show", :id => @poll.id
    
  end

  def process_single_vote
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

  def process_open_vote
    @answer = Answer.new(params[:answer])
    @poll = Poll.find(params[:poll])
    @answer.answer_possibility_id = nil
    @answer.poll_id = @poll.id
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
