class JsSolutionsController < ApplicationController
  
  def create
    user_id = current_user.id
    challenge_id = params["challenge_id"]
    method_string = params["method_string"]
    success = (params["success"] == "true")

    logger.info("HELLOHELLO")
    logger.info(challenge_id)
    logger.info(method_string)
    logger.info(success)
    logger.info(success.class)

  end

end
