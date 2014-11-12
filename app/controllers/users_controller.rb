class UsersController < ApplicationController
  before_action :require_signed_out!, :only => [:create, :new]

  def new
    @user = User.new
    render :new, :layout => false
  end

  def create
    @user = User.new(user_params)
    @user.admin = false

    if @user.save
      sign_in(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new, :layout => false
    end
  end

  def show
    if params.include?(:id)
      @user = User.find(params[:id])
    else
      redirect_to user_url(current_user)
    end
  end

  def edit
    @user = current_user
    unless params.include?(:id) && current_user.id == params[:id].to_i     
      redirect_to user_url(current_user)
    end
    render :edit, :layout => false
  end
  
  def update
    @user = current_user
    if params.include?(:id) && current_user.id == params[:id].to_i && @user.update_attributes(user_update_params)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def index
    @users = User.all
    @users.sort! { |a,b| b.percent_gain <=> a.percent_gain }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  
  def user_update_params
      params.require(:user).permit(:name, :email)
  end
end