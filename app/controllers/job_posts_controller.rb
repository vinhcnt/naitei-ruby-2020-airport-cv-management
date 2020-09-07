class JobPostsController < ApplicationController
  load_and_authorize_resource education_params: :job_post_params
  skip_load_and_authorize_resource only: :index
  rescue_from CanCan::AccessDenied, with: :cancan_access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :active_record_record_not_found

  def index
    @q = JobPost.ransack params[:q]
    @job_posts = @q.result(distinct: true).page(params[:page]).per Settings.job_posts.per_page
  end

  def new; end

  def show
    @job_application = current_user.job_applications.find_job_appl(params[:id]).desc_order.first
    @job_app = JobApplication.new job_post_id: params[:id], candidate_id: current_user.id
  end

  def create
    @job_post.user = current_user
    if @job_post.save
      flash[:success] = t ".success"
      redirect_to job_post_path @job_post
    else
      flash[:error] = t ".error"
      render :new
    end
  end

  private

  def job_post_params
    params.require(:job_post).permit JobPost::JOBPOST_PARAMS
  end

  def cancan_access_denied
    flash[:error] = t "shared.error_messages.you_are_not_allow_to_do_this_action"
    redirect_to root_url
  end

  def active_record_record_not_found
    flash[:warning] = t "shared.error_messages.job_post_not_found"
    redirect_to root_path
  end
end
