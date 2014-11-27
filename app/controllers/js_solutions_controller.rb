class JsSolutionsController < ApplicationController
  
  def create
    user_id = current_user.id

    logger.info("HELLOHELLO")
  end

end
