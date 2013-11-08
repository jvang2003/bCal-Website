class RequestController < ApplicationController
  before_action :check_auth

  def new
  end

  def create
    to_pass = params.extract! %w[people details reason place]
    to_pass[:time] = DateTime.new(params["date"]["(1i)"].to_i,params["date"]["(2i)"].to_i,params["date"]["(3i)"].to_i,params["time"]["(4i)"].to_i,params["time"]["(5i)"].to_i)
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
end
