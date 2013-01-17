class PollsController < ApplicationController
	before_filter :authenticate_creator!
	require 'gchart'


	def index		
	 @polls = Poll.where(creator_id: current_creator.id)
	end

	def edit
	  @poll = Poll.find(params[:id])
	end

	def update
	  @poll = Poll.find(params[:id])

	  respond_to do |format|
	    if @poll.update_attributes(params[:poll])

       unless params[:poll][:answer_possibilities_attributes].nil?

        answer_possibilities = params[:poll][:answer_possibilities_attributes]
        answer_possibilities.each do |k,v|
          unless v.fetch("_destroy").eql?("1")
            answerPossibility=nil
            if v.key?("id")
              answerPossibility = @poll.answer_possibilities.find(v.fetch("id"))
            else          
              answerPossibility = AnswerPossibility.new
              answerPossibility.poll_id = @poll.id
            end
            answerPossibility.value=v.fetch("value")
            answerPossibility.save
          end
        end

      end


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
    if @poll.creator_id== current_creator.id 

      @resultdata={}
      uanswers=@poll.answers.group(:guid).count
      @unique_answers=uanswers.count    

      data=[]
      labels=[]
      @poll.answer_possibilities.each do |p|
        @resultdata[p.value] = p.answers.count
        data << p.answers.count
        labels << p.value + " (" + p.answers.count.to_s + ")"
      end
      on_class = "Gchart"
      @chart_url= on_class.constantize.send(@poll.chart_type, :title => @poll.title, :size => '500x300',:data => data, :labels => labels )

    else
      redirect_to polls_path, notice: "Die Umfrage kann nur vom Ersteller eingesehen werden."
    end
        
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
