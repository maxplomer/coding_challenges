class JsSolutionsController < ApplicationController
  
  def create
    user_id = current_user.id
    challenge_id = params["challenge_id"]
    method_string = params["method_string"]
    success = (params["success"] == "true")
    language = "JavaScript"

    @solution = Solution.new(
      user_id: user_id, 
      challenge_id: challenge_id, 
      method_string: method_string, 
      success: success,
      language: language
    )

    challenge = Challenge.find(challenge_id)
    if current_user.have_solved?(challenge, language)
      flash[:errors] = ["You already solved this challenge in JavaScript."]
      render json: @solution
      return
    end

    if @solution.save
      render json: @solution
    else
      render :json => @solution.errors, :status => :unprocessable_entity
    end

  end

end
