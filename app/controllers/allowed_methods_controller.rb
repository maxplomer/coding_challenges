class AllowedMethodsController < ApplicationController

  def new
    @allowed_method = AllowedMethod.new
    render :new
  end

  def create
    challenge_name = params["allowed_method"]["challenge_name"]
    challenge_id = Challenge.find_by_name(challenge_name).id
    allowed_methods = params["allowed_method"]["allowed_methods"].gsub(" ","").split(',')

    allowed_methods.each do |method|
      AllowedMethod.create(
        challenge_id: challenge_id,
        method: method
      )
    end

    redirect_to root_url
  end

end
