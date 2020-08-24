class ProfilesController < ApplicationController
  before_action :correct_user_or_recruiter

  def show; end

  private

  def correct_user_or_recruiter
    @user = User.find_by id: params[:id]
    redirect_to root_url unless (@user == current_user) || current_user&.is_recruiter?
    if @user
      @profile = @user.profile
    else
      flash[:error] = t ".user_not_found"
      redirect_to root_path
    end
  end
end
