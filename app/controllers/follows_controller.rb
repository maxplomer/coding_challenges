class FollowsController < ApplicationController

  def create
    follower_id = params[:follow][:follower_id]
    leader_id = params[:follow][:leader_id]

    Follow.create(follower_id: follower_id, leader_id: leader_id)

    redirect_to user_url(leader_id)
  end

  def destroy
    follower_id = params[:follow][:follower_id]
    leader_id = params[:follow][:leader_id]
    follow = Follow.where(follower_id: follower_id, leader_id: leader_id)[0]
    follow.destroy
    redirect_to user_url(leader_id)
  end

  def easy
    @users = current_user
      .users_they_follow
      .sort! { |a,b| b.number_easy_submissions <=> a.number_easy_submissions }
    @easy_button_class = "current-button"
    render :index
  end

  def medium
    @users = current_user
      .users_they_follow
      .sort! { |a,b| b.number_medium_submissions <=> a.number_medium_submissions }
    @medium_button_class = "current-button"
    render :index
  end

  def hard
    @users = current_user
      .users_they_follow
      .sort! { |a,b| b.number_hard_submissions <=> a.number_hard_submissions }
    @hard_button_class = "current-button"
    render :index
  end

end
