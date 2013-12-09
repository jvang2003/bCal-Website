class SessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:create, :new]

  def new
  end

  def create
    session_params = params[:session]
    user = User.find_by_calnet_id(session_params[:calnet_id])
    if user
      sign_in user
      redirect_back_or root_path
    else
      flash[:notice] = "Please sign up"
      redirect_to new_user_path("user[calnet_id" => session_params[:calnet_id], :return_to => params[:return_to])
    end
  end

  def destroy
    sign_out
    redirect_to calendars_path
  end
end
