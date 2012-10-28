class PollController < ApplicationController
  def show
  end

  def vote
     @poll=Poll.find(params[:id])     
  end
  
  def process_vote
    @answer = Answer.new
  end
end
