class InputResultsController < ApplicationController

  def new
    @input_result = InputResult.new
    render :new
  end


  def create
    @input_result = InputResult.new(input_result_params)

    if @input_result.save
      redirect_to root_url
    else
      flash.now[:errors] = @input_result.errors.full_messages
      render :new
    end
  end

  private

  def input_result_params
    params.require(:input_result).permit(
      :challenge_id, 
      :input, 
      :result
    )
  end


end
