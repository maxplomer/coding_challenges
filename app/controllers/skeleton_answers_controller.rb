class SkeletonAnswersController < ApplicationController

  def new
    @skeleton_answer = SkeletonAnswer.new
    render :new
  end

  def create
    @skeleton_answer = SkeletonAnswer.new(skeleton_answer_params)
    challenge_name = params["skeleton_answer"]["challenge_name"]
    @skeleton_answer.challenge_id = Challenge.find_by_name(challenge_name).id

    if @skeleton_answer.save
      redirect_to root_url
    else
      flash.now[:errors] = @skeleton_answer.errors.full_messages
      render :new
    end
  end

  private

  def skeleton_answer_params
    params.require(:skeleton_answer).permit(:method_skeleton, :answer, :language)
  end

end
