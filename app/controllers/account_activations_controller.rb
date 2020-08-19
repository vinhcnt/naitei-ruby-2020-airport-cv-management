class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user&.authenticated?(:activation, params[:id]) && !user.activated?
      user.activate
      log_in user
      flash[:success] = t ".account_activated"
    else
      flash[:error] = t ".invalid_activation_link"
    end
    redirect_to root_url
  end
end
