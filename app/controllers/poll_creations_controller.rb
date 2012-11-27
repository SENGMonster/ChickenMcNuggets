class PollCreationsController < ApplicationController
	def index
		@polls = Poll.all
	end

	def new
	    @poll = Poll.new
	    3.times do
	    	@poll.answer_possibilities.build
	    end
	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @poll }
	    end
	end

	def create
	  @poll = Poll.new(params[:poll])

	  respond_to do |format|
	    if @poll.save
	      format.html { redirect_to poll_creations_path notice: 'Newsentry was successfully created.' }
	      format.json { render json: @poll, status: :created, location: @poll }
	    else
	      format.html { render action: "new" }
	      format.json { render json: @poll.errors, status: :unprocessable_entity }
	    end
	  end
	end


end
