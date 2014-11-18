class PicturesController < ApplicationController

  def new
    @picture = Picture.new
    render :new
  end


  def create
    @picture = Picture.new(picture_params)
    challenge_name = params["picture"]["challenge_name"]
    @picture.challenge_id = Challenge.find_by_name(challenge_name).id

    if @picture.save
      redirect_to root_url
    else
      flash.now[:errors] = @picture.errors.full_messages
      render :new
    end
  end

  private

  def picture_params
    params.require(:picture).permit(:url)
  end

end
