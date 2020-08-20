class JobApplicationsController < ApplicationController
  def index
    if current_user.is_recruiter?
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

  private

  def candidate_index
    return unless current_user.is_candidate?

    @job_applications = current_user.job_applications
                                    .desc_order
                                    .page(params[:page])
                                    .per Settings.job_applications.per_page
  end
end
