class RequestController < ApplicationController
  #before_filter :check_auth # was before_action, that's for rails 4

  def new
  end

  def create
    #to_pass = params.extract! %w[people details reason place course_related accept_different_room department] This doesn't work.
    to_pass = {}
    to_pass[:people] = params[:people]
    to_pass[:details] = params[:details]
    to_pass[:reason] = params[:reason]
    to_pass[:place] = params[:place]
    to_pass[:course_related] = params[:course_related]
    to_pass[:accept_different_room] = params[:accept_different_room]
    to_pass[:department] = params[:department]
    to_pass[:time] = DateTime.new(params["date"]["(1i)"].to_i,params["date"]["(2i)"].to_i,params["date"]["(3i)"].to_i,params["time"]["(4i)"].to_i,params["time"]["(5i)"].to_i)
    to_pass[:status] = "pending"
    #Request.create! #need to delete and replace with the commented line below
    Request.create! to_pass
    RequestMailer.request_successful(params).deliver
    flash[:notice]="Request has been submitted"
    redirect_to calendars_path
  end

  def check_auth
  	res = RequestHelper::check_auth
  	if res != nil
  		redirect_to res
  	end
  end

  def show
        print(Request.all)
  	@requests = Request.all
  	# @requests = Request.all(:user_id => @user_id) #TODO: ACTUALLY MAKE THIS USE THE USER ID!!!!
  end
end
