class RequestController < ApplicationController
  def new
  end
  def create
    time=DateTime.new(params["date"]["(1i)"].to_i,params["date"]["(2i)"].to_i,params["date"]["(3i)"].to_i,params["time"]["(4i)"].to_i,params["time"]["(5i)"].to_i)
    Request.create!(:details=>params["details"],:people => params["people"], :reason => params["reason"],:place => params["place"],:time=>time)
    RequestMailer.request_successful(params).deliver
    flash[:notice]="Request has been submitted"
    redirect_to calendars_path
  end
  def show
  	@requests = Request.all
  	# @requests = Request.all(:user_id => @user_id) #TODO: ACTUALLY MAKE THIS USE THE USER ID!!!!
  end
end
