class PollCreationsController < ApplicationController
	def index
		@polls = Poll.all
	end

	def edit
	  @poll = Poll.find(params[:id])
	end

	def update
	  @poll = Poll.find(params[:id])

	  respond_to do |format|
	    if @poll.update_attributes(params[:poll])
	      format.html { redirect_to poll_creations_path, notice: 'Poll was successfully updated.' }
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
	  #binding.pry

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

	      format.html { redirect_to poll_creations_path notice: 'Newsentry was successfully created.' }
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
      format.html { redirect_to poll_creations_path }
      format.json { head :no_content }
    end
  end


end
