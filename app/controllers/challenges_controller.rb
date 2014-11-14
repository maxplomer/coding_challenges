class ChallengesController < ApplicationController

  def new
    @challenge = Challenge.new
    render :new
  end

  def create
    @challenge = Challenge.new(challenge_params)
    input = params["challenge"]["input"]
    result = params["challenge"]["result"] #will have to convert user answer to string to compare
    allowed_methods = params["challenge"]["allowed_methods"].gsub(" ","").split(',')

    #can later try to refill the form with @input and @result if error occured

    if @challenge.save
      save_spec_and_methods(@challenge.id, input, result, allowed_methods)
      redirect_to root_url
    else
      flash.now[:errors] = @challenge.errors.full_messages
      render :new
    end
  end


  private

  def save_spec_and_methods(challenge_id, input, result, allowed_methods)
    allowed_methods.each do |method|
      AllowedMethod.create(
        challenge_id: challenge_id,
        method: method
      )
    end

    InputResult.create(
      challenge_id: challenge_id,
      input: input,
      result: result
    )

  end

  def challenge_params
    params.require(:challenge).permit(
      :name,
      :difficulty, 
      :description, 
      :problem_statement,
      :method_skeleton,
      :answer
    )
  end

end
