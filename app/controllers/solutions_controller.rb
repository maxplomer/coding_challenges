class SolutionsController < ApplicationController

  def create
  	user_id = current_user.id
    challenge_id = params["solution"]["challenge_id"]
  	method_string = params["solution"]["method_string"]

  	@solution = Solution.new(
  	  user_id: user_id, 
  	  challenge_id: challenge_id, 
  	  method_string: method_string, 
  	  success: false
  	)
    begin
      @solution.success = @solution.success?
    rescue Exception

    end

    if @solution.save
      redirect_to root_url #later redirect to current_user show page
    else
      flash.now[:errors] = @solution.errors.full_messages
      render :new
    end
  end

end
