class RequestsController < ApplicationController
  def self.can_view? user
    user && user.role >= 0
  end

  def self.can_crud? user
    user && user.role >= 0
  end

  def new
    @request = Request.new
  end

  def create
    date=params["date"].split("/")

    to_pass = {}
    %w(people details reason place course_related accept_different_room department email).each do |attr|
      to_pass[attr] = params[:request][attr]
    end

    to_pass[:time] = DateTime.new date[2].to_i,date[0].to_i,date[1].to_i,params["time"]["(4i)"].to_i,params["time"]["(5i)"].to_i, 0,"-8"
    to_pass[:status] = :pending

    Request.create! to_pass
    RequestMailer.request_successful(params).deliver

    flash[:notice]="Request has been submitted"
    redirect_to calendars_path
  end

  def index
    @requests = Request.all
    # @requests = Request.all(:user_id => @user_id) #TODO: ACTUALLY MAKE THIS USE THE USER ID!!!!
  end

  def edit
     @request = Request.find(params[:id])
     prev_status = @request.status
     @request.status = params[:status] unless params[:status] == nil
     calendar = Calendar.find_by_name(@request.place)
     @request.calendar = calendar if @request.calendar == nil
     @request.save!
     if (params[:status])
       RequestMailer.status_changed(@request).deliver
       if (prev_status != "approved" and @request.status == "approved" and calendar.access_token != nil)
         @event = Event.new
         @request.event = @event
         @request.event.update_gcal
       elsif (params[:status] and (@request.status == "rejected" or @request.status == "pending") and calendar.access_token != nil)
         if @request.event
           @request.event.delete_event
           @request.event.destroy
         end
       end
       flash[:notice] = "Request Status has been updated."
       redirect_to requests_path
    end
  end
end
