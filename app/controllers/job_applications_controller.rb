class JobApplicationsController < ApplicationController
  before_action :authenticate_user!
  STATUS_PARAMS = %i(status).freeze
  load_and_authorize_resource param_method: :job_application_params
  rescue_from CanCan::AccessDenied, with: :cancan_access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :active_record_record_not_found

  def index
    if current_user.has_role? :recruiter
      @job_applications = JobApplication.desc_order
                                        .page(params[:page])
                                        .per Settings.job_applications.per_page
    else
      candidate_index
    end
    respond_to do |format|
      format.html{render :index}
      format.js
    end
  end

  def create
    if @job_application.save
      flash[:success] = t "send.ok"
      redirect_to job_applications_path
    else
      flash[:error] = t "send.error"
      redirect_to root_url
    end
  end

  def update
    @job_application = JobApplication.find_by id: params[:id]
    update_status if current_user.has_role?(:recruiter) || current_user.eql?(@job_application&.candidate)
  end

  private

  def job_application_params
    params[:job_application] = {}
    params[:job_application][:job_post_id] = params[:id]
    params[:job_application][:candidate_id] = current_user&.id

    params.require(:job_application).permit :job_post_id, :candidate_id
  end

  def status_params
    params.require(:job_application).permit STATUS_PARAMS
  end

  def candidate_index
    return unless current_user.has_role? :candidate

    @job_applications = current_user.job_applications
                                    .desc_order
                                    .page(params[:page])
                                    .per(Settings.job_applications.per_page)
  end

  def update_status
    if @job_application.update status_params
      flash.now[:success] = t ".success"
    else
      flash.now[:error] = t ".error"
    end
    respond_to do |format|
      format.js
    end
  end

  def cancan_access_denied
    flash[:error] = t "shared.error_messages.you_are_not_allow_to_do_this_action"
    redirect_to root_url
  end

  def active_record_record_not_found
    flash[:warning] = t "shared.error_messages.job_application_not_found"
    redirect_to root_path
  end
end
