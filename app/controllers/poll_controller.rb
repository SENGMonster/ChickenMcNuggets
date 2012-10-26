class PollController < ApplicationController
  def show
  end

  def vote
    
     @poll=Poll.find(params[:id])
  end
end
