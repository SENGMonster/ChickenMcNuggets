class PollsController < ApplicationController
	before_filter :authenticate_creator!
	require 'gchart'


	def index		
	 @polls = Poll.where(creator_id: current_creator.id).group("category_id")
	end

	def edit
	  @poll = Poll.find(params[:id])
	end

	def update
	  @poll = Poll.find(params[:id])

	  respond_to do |format|
	    if @poll.update_attributes(params[:poll])
	      format.html { redirect_to polls_path, notice: 'Poll was successfully updated.' }
	      format.json { head :no_content }
	    else
	      format.html { render action: "edit" }
	      format.json { render json: @poll.errors, status: :unprocessable_entity }
	    end
	  end
	end

	def new
	    @poll = Poll.new
	    @poll.start_date = Date.today+1.day
	    @poll.exp_date = Date.today+7.day
	    @poll.chart_type = "pie"

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @poll }
	    end
	end

	def create
	  @poll = Poll.new(params[:poll])
	  @poll.creator_id = current_creator.id
	  @poll.shorturl = tinyfy("http://0.0.0.0:3000/polls/#{@poll.id}")
	

	  respond_to do |format|
	    if @poll.save

			answer_possibilities = params[:poll][:answer_possibilities_attributes]
			answer_possibilities.each do |k,v|
				v.each do |k1,v1|
		  		answerPossibility = AnswerPossibility.new
		  		answerPossibility.value = v1
		  		answerPossibility.poll_id = @poll.id
		  		answerPossibility.save
				end
		  end


	      format.html { redirect_to polls_path notice: 'Newsentry was successfully created.' }
	      format.json { render json: @poll, status: :created, location: @poll }
	    else
	      format.html { render action: "new" }
	      format.json { render json: @poll.errors, status: :unprocessable_entity }
	    end
	  end
	end

  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy

    respond_to do |format|
      format.html { redirect_to polls_path }
      format.json { head :no_content }
    end
  end

  def show
    ##https://github.com/mattetti/googlecharts
    @poll=Poll.find(params[:id])
    @comments = 
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

  def tinyfy(newurl)
   url = URI.parse('http://tinyurl.com/')
   res = Net::HTTP.start(url.host, url.port) {|http|
   http.get('/api-create.php?url=' + newurl)
   }
   if res.body.empty?
      #tinyurl is not responding properly… Return the original url
      return newurl
   else
      return res.body
   end
  end

end
