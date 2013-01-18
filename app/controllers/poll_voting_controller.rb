require 'gchart'
class PollVotingController < ApplicationController
  before_filter :check_session, :only => [:vote]
  before_filter :check_exp_date, :only => [:vote]

 
  def show
    ##https://github.com/mattetti/googlecharts
    @poll=Poll.find(params[:id])
    data=[]
    labels=[]
    @poll.answer_possibilities.each do |p|
      data << p.answers.count
      labels << p.value + " (" + p.answers.count.to_s + ")"
    end
    on_class = "Gchart"
    @chart_url= on_class.constantize.send(@poll.chart_type, :title => @poll.title, :size => '400x200',:data => data, :labels => labels )
    #@chart_url=Gchart.pie_3d(:title => @poll.title, :size => '400x200',:data => data, :labels => labels )
    #@bar_url=Gchart.bar(:data => data, :bar_width_and_spacing => '25,50', :labels => labels)        
  end

  def vote
     @poll=Poll.find(params[:id])
     @answer = Answer.new     
  end

  def process_multiple_vote  
    @poll = Poll.find(params[:poll])
    answer_ids = params[:answer_ids]
   
    n_guid = SecureRandom.uuid
    commentid = create_comment(params[:comment],@poll.id)

    answer_ids.each do |answer_id|
      answer = Answer.new(params[:answer])
      answer.guid = n_guid
      answer.answer_possibility_id = AnswerPossibility.find(answer_id).id
      answer.value =AnswerPossibility.find(answer_id).value
      answer.os = RUBY_PLATFORM;
      answer.browser = request.env['HTTP_USER_AGENT'];
      answer.ip = request.env['REMOTE_ADDR'];
      answer.poll_id = @poll.id
      answer.comment_id = commentid
      answer.save      
    end

    session[@poll.id] = 1
    redirect_to :action => "show", :id => @poll.id
    
  end

  def process_single_vote
    @poll = Poll.find(params[:poll])

    commentid = create_comment(params[:comment],@poll.id)

    answer = Answer.new(params[:answer])
    answer.guid = SecureRandom.uuid
    @poll = Poll.find(params[:poll])
    answer_possibility = AnswerPossibility.find(params[:"radio-choice"])
    answer.answer_possibility_id = answer_possibility.id
    answer.value = answer_possibility.value
    answer.os = RUBY_PLATFORM;
    answer.browser = request.env['HTTP_USER_AGENT'];
    answer.ip = request.env['REMOTE_ADDR'];
    answer.poll_id = @poll.id
    answer.comment_id = commentid
    session[@poll.id] = 1    

    respond_to do |format|
      if answer.save
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

  def check_exp_date
    @poll=Poll.find(params[:id])
    current_date = Date.today
    if @poll.exp_date <= current_date
      redirect_to :action => "show", :id => @poll.id
    end
    

  end

  def create_comment(input_text, pid)
    unless input_text.empty?
      c = Comment.new
      c.poll_id=pid
      c.text= input_text
      c.save
      return c.id
    else
      return nil
    end
  end
  
end
