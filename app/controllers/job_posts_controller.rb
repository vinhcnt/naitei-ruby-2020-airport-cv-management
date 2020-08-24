class JobPostsController < ApplicationController
  before_action :recruiter_user

  def index; end

  def new
    @job_post = JobPost.new
  end

  def create
    @job_post = current_user.job_posts.build job_post_params
    if @job_post.save
      flash[:success] = t ".success"
      redirect_to root_path
    else
      flash[:error] = t ".error"
      render :new
    end
  end

  private

  def job_post_params
    params.require(:job_post).permit JobPost::JOBPOST_PARAMS
  end

  def recruiter_user
    redirect_to root_url unless current_user.is_recruiter?
  end
end
