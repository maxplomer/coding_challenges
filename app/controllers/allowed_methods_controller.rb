class AllowedMethodsController < ApplicationController

  def new
    @allowed_method = AllowedMethod.new
    render :new
  end


  def create
    @allowed_method = AllowedMethod.new(allowed_method_params)

    if @allowed_method.save
      redirect_to root_url
    else
      flash.now[:errors] = @allowed_method.errors.full_messages
      render :new
    end
  end

  private

  def allowed_method_params
    params.require(:allowed_method).permit(
      :challenge_id, 
      :method
    )
  end

end
