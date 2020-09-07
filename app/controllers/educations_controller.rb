class EducationsController < ApplicationController
  load_and_authorize_resource param_method: :education_params
  rescue_from CanCan::AccessDenied, with: :cancan_access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :active_record_record_not_found

  def create
    @new_education = Education.new profile_id: current_user.profile_id
    if @education.save
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
    if @education.destroy
      flash.now[:success] = t ".success"
    else
      flash.now[:error] = t ".error"
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def education_params
    params.require(:education).permit Education::EDUCATION_PARAMS
  end

  def cancan_access_denied
    flash[:error] = t ".you_are_not_allow_to_do_this_action"
    redirect_to root_url
  end

  def active_record_record_not_found
    flash[:warning] = t ".not_found"
    redirect_to root_path
  end
end
