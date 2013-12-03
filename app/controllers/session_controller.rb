class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by_calnet_id(params[:session][:calnet_id])
    if user
      sign_in user
      redirect_back_or calendars_path
    else
      flash.now[:error] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    sign_out
    redirect_to calendars_path
  end
end
