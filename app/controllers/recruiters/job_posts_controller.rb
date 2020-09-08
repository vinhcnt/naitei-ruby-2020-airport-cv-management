class Recruiters::JobPostsController < ApplicationController
  layout "recruiters_application"
  before_action :must_be_a_recruiter
  load_and_authorize_resource param_method: :job_post_params
  skip_load_and_authorize_resource only: :index
  rescue_from CanCan::AccessDenied, with: :cancan_access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :active_record_record_not_found

  def index
    @q = JobPost.ransack params[:q]
    @job_posts = @q.result(distinct: true).page(params[:page]).per Settings.job_posts.per_page
  end

  def new; end

  def show; end

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
    flash[:error] = t ".you_are_not_allow_to_do_this_action"
    redirect_to root_url
  end

  def active_record_record_not_found
    flash[:warning] = t ".job_post_not_found"
    redirect_to root_path
  end

  def must_be_a_recruiter
    return if current_user&.has_role? :recruiter

    flash[:error] = t ".you_are_not_allow_to_do_this_action"
    redirect_to root_path
  end
end
