class ChallengesController < ApplicationController

  def new
    @challenge = Challenge.new
    render :new
  end

  def create
    @challenge = Challenge.new(challenge_params)  #can later try to refill the form if error occured

    if @challenge.save
      redirect_to root_url
    else
      flash.now[:errors] = @challenge.errors.full_messages
      render :new
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    render :show
  end

  def easy
    @challenges = Challenge.all.select{ |i| i.difficulty == "easy" }
    @easy_button_class = "current-button"
    render :index
  end

  def medium
    @challenges = Challenge.all.select{ |i| i.difficulty == "medium" }
    @medium_button_class = "current-button"
    render :index
  end

  def hard
    @challenges = Challenge.all.select{ |i| i.difficulty == "hard" }
    @hard_button_class = "current-button"
    render :index
  end


  private

  def challenge_params
    params.require(:challenge).permit(
      :name,
      :difficulty, 
      :description, 
      :problem_statement
    )
  end

end
