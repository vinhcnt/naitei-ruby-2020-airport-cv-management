class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t "shared.user_not_found"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new candidate_params
    if @user.save
      @user.send_activation_email
      flash[:success] = t ".success"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def candidate_params
    params.require(:user).permit User::USER_PARAMS
  end

  def render_singup
    render action: :new
  end
end
