class RequestController < ApplicationController
  def new
  end
  def create
    Request.create!(:details=>params["details"],:people => params["people"], :reason => params["reason"],:place => params["place"])
    flash[:notice]="Request has been submitted"
    redirect_to calendars_path
  end
end
