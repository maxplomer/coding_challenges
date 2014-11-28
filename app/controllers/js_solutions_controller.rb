class JsSolutionsController < ApplicationController
  
  def create
    user_id = current_user.id
    challenge_id = params["challenge_id"]
    method_string = params["method_string"]
    success = (params["success"] == "true")
    language = "JavaScript"

    challenge = Challenge.find(challenge_id)
    if current_user.have_solved?(challenge, language)
      flash[:errors] = ["You already solved this challenge in JavaScript."]
      redirect_to user_url(current_user)
      return
    end

    @solution = Solution.new(
      user_id: user_id, 
      challenge_id: challenge_id, 
      method_string: method_string, 
      success: success,
      language: language
    )

    if @solution.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @solution.errors.full_messages
      render :new
    end

  end

end
