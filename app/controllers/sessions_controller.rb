class SessionsController < ApplicationController
  skip_before_filter :require_login, :only => :new

  def new
    puts session
    if session["cas"] && session["cas"]["user"]
      user = User.find_by_calnet_id(session["cas"]["user"])
      puts "found user #{user}"
      if user
        sign_in user
        redirect_back_or root_path
      else
        flash[:notice] = "Please sign up"
        redirect_to new_user_path("user[calnet_id]" => session["cas"]["user"], :return_to => params[:return_to])
      end
    else
      render :file => "static/401", :status => :unauthorized
    end
  end

  def destroy
    sign_out
    redirect_to calendars_path
  end
end
