class JobApplicationsController < ApplicationController
  def index
    @job_applications = current_user.job_applications
                                    .desc_order
                                    .page(params[:page])
                                    .per Settings.job_applications.per_page

    respond_to do |format|
      format.html{render :index}
      format.js
    end
  end
end
