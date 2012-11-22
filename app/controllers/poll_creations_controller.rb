class PollCreationsController < InheritedResources::Base
	def index
		@polls = Poll.all
	end

	def new
	    @poll_creation = PollCreation.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @poll_creation }
	    end
	end

	def create
	  @poll_creation = PollCreation.new(params[:poll_creation])

	  respond_to do |format|
	    if @poll_creation.save
	      format.html { redirect_to poll_creations_path notice: 'Newsentry was successfully created.' }
	      format.json { render json: @poll_creation, status: :created, location: @poll_creation }
	    else
	      format.html { render action: "new" }
	      format.json { render json: @poll_creation.errors, status: :unprocessable_entity }
	    end
	  end
	end


end
