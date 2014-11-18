class SolutionsController < ApplicationController

  def create
  	user_id = current_user.id
    challenge_id = params["solution"]["challenge_id"]
  	method_string = params["solution"]["method_string"]

    challenge = Challenge.find(challenge_id)
    if current_user.have_solved?(challenge)
      flash[:errors] = ["You already solved this challenge."]
      redirect_to user_url(current_user)
      return
    end

  	@solution = Solution.new(
  	  user_id: user_id, 
  	  challenge_id: challenge_id, 
  	  method_string: method_string, 
  	  success: false
  	)

    timeout_in_seconds = 10

    begin
      Timeout::timeout(timeout_in_seconds) do
        @solution.success = @solution.success?
      end
    rescue Exception

    end

    if @solution.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @solution.errors.full_messages
      render :new
    end
  end

end
