class SqlChallengesController < ApplicationController

  def show
    @challenge = Challenge.find(params[:id])
    render :show
  end
  
end
