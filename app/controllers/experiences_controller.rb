class ExperiencesController < ApplicationController
  load_and_authorize_resource param_method: :experience_params
  rescue_from CanCan::AccessDenied, with: :cancan_access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :active_record_record_not_found

  def create
    @new_experience = Experience.new profile_id: current_user.profile_id
    if @experience.save
      flash.now[:success] = t ".success"
    else
      flash.now[:error] = t ".error"
    end

    respond_to do |format|
      format.js
    end
  end

  def update; end

  def destroy
    if @experience.destroy
      flash.now[:success] = t ".success"
    else
      flash.now[:error] = t ".error"
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def experience_params
    params.require(:experience).permit Experience::EXPERIENCE_PARAMS
  end

  def cancan_access_denied
    flash[:error] = t "shared.error_messages.you_are_not_allow_to_do_this_action"
    redirect_to root_url
  end

  def active_record_record_not_found
    flash[:warning] = t "shared.error_messages.not_found"
    redirect_to root_path
  end
end
